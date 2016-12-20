defmodule Mapping.Registry do
  @moduledoc """
  Maintains registry of Mapping Servers. Looks up existing servers and 
  manages the creation of new ones as neede
  """
  
  use GenServer

  @name __MODULE__

  #
  # API External Interface
  #
  @doc"""
  Start a registry with the given `name`
  """
  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end
  

  @doc"""
  Looks up the pid for the mapping server specified by `name`

  returns `{:ok, pid}` if exists, otherwise returns :error
  Looks up values directly from ets tables so no GenServer call is needed
  """
  def lookup(server, name) when is_atom(server) do
    case :ets.lookup(server, name) do
      [{^name, map_server}] -> {:ok, map_server}
      [] -> :error
    end
  end


  @doc"""
  Creates a new mapping server with `name`
  """
  def create(server, name, project_id, api_token) do
    GenServer.call(server, {:create, name, project_id, api_token})
  end
  
  
  #
  # Callbacks
  #
  def init(name) do
    names = :ets.new(name, [:named_table, read_concurrency: :true])
    refs =  %{}
    {:ok, {names, refs}}
  end


  def handle_call({:create, name, project_id, api_token}, _from, {names, refs}) do
    case lookup(names, name) do
      {:ok, pid} ->
    	{:reply, pid, {names, refs}}

      :error ->
    	{:ok, pid} = Mapping.Supervisor.start_mapping_worker(name, project_id, api_token)
    	ref = Process.monitor(pid)
    	refs = Map.put(refs, ref, name)
    	:ets.insert(names, {name, pid})
    	{:reply, pid, {names, refs}}
    end
  end
  

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    :ets.delete(names, name)
    {:noreply, {names, refs}}
  end


  def handle_info(_msg, state) do
    {:noreply, state}
  end
  
    

end
