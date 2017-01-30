defmodule Mapping.MapServer do
  use GenServer

  defmodule State do
    defstruct proj_id: nil,
      api_token: nil,
      id: nil
    end
    

  #
  # API
  #
  def start_link(name, proj_id, api_token) do
    id = {:via, Registry, {Mapping.Registry, name}}
    GenServer.start_link(__MODULE__, [id, proj_id, api_token], name: id)
  end



  #
  # Callbacks
  #
  def init([id, proj_id, api_token]) do
    state = %State{id: id, proj_id: proj_id, api_token: api_token}
    {:ok,  state}
  end


  #
  # Private
  #
  

end
