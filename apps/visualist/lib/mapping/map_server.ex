defmodule Mapping.MapServer do
  use GenServer

  defmodule State do
    defstruct proj_id: nil,
      api_token: nil,
      name: nil
    end
    

  #
  # API
  #
  def start_link(name, proj_id, api_token) do
    GenServer.start_link(__MODULE__, [name, proj_id, api_token], [name])
  end



  #
  # Callbacks
  #
  def init([name, proj_id, api_token]) do
    state = %State{name: name, proj_id: proj_id, api_token: api_token}
    {:ok,  state}
  end


  #
  # Private
  #

end
