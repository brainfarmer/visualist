defmodule Mapping.Users.Server do
  use GenServer

  @name __MODULE__

  #
  # API
  #
  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end


  def add(name, api_token) when is_binary(name) do
    GenServer.call(@name, {:add, name, api_token})
  end


  def lookup(name) when is_binary(name) do
    GenServer.call(@name, {:lookup, name})
  end


  def remove(name) when is_binary(name) do
    GenServer.call(@name, {:remove, name})
  end

  
  #
  # Callbacks
  #
  def init(:ok) do
    users = %{}
    refs = %{}
    {:ok, {users, refs}}
  end


  def handle_call({:add, name, api_token}, _from, {users, refs}) do
    {:ok, pid} = Mapping.Users.UserSupervisor.new_user(api_token)
    ref = Process.monitor(pid)
    refs = Map.put(refs, ref, name)
    users = Map.put(users, name, {name, pid})
    {:reply, {:ok, pid}, {users, refs}}
  end
  

  def handle_call({:lookup, name}, _from, {users, refs}) do
    value = 
      case _lookup(users, name) do
	{:ok, pid} -> {:ok, pid}
	:error -> :error
      end
    {:reply, value, {users, refs}}
  end

  
  def handle_call({:remove, name}, _from, {users, refs}) do
    value = 
      case _lookup(users, name) do
	{:ok, user_pid} -> Mapping.Users.User.stop(user_pid)
	:error -> :ok
      end
    {:reply, value, {users, refs}}
  end


  def handle_info({:DOWN, ref, :process, _pid, _reason}, {users, refs}) do
    {name, updated_refs} = Map.pop(refs, ref)
    {{_name, _pid}, updated_users} = Map.pop(users, name)
    {:noreply, {updated_users, updated_refs}}
  end

  
  def handle_info(_msg, state) do
    {:noreply, state}
  end
  
  
  
  
  
  #
  # Private
  #
  # defp auto_increment(map) when map == %{}, do: 1
  # defp auto_increment(users) do
  #   Map.keys(users)
  #   |> List.last
  #   |> Kernel.+(1)
  # end

  
  defp _lookup(users, name) do
    case Map.fetch(users, name) do
      {:ok, {_name, pid}} -> {:ok, pid}
      :error -> :error
    end
  end
  
  
end

  
