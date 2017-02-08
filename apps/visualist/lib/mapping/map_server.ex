defmodule Mapping.MapServer do
  use GenServer

  defmodule State do
    defstruct proj_id: nil,
      api_token: nil,
      id: nil,
      name: nil
    end
    

  #
  # API
  #
  def start_link(name, proj_id, api_token) do
    id = {:via, Registry, {Mapping.Registry, name}}
    GenServer.start_link(__MODULE__, [id, name, proj_id, api_token], name: id)
  end

  
  def get_story_map(server, proj_id, api_token) do
    GenServer.call(server, {:get_story_map, proj_id, api_token})
  end
  

  #
  # Callbacks
  #
  def init([id, name, proj_id, api_token]) do
    state = %State{id: id, name: name, proj_id: proj_id, api_token: api_token}
    {:ok,  state}
  end


  def handle_call({:get_story_map, proj_id, api_token}, _from, state) do
    task_sup_id = :"#{state.name}.MapTaskSupervisor"

    epics_task = Task.Supervisor.async(task_sup_id,
      fn -> Tracker.Worker.get(:epics, proj_id, api_token) end)
    stories_task = Task.Supervisor.async(task_sup_id,
      fn -> Tracker.Worker.get(:stories, proj_id, api_token) end)
   
    {:ok, epic_data} = Task.await(epics_task)
    {:ok, story_data} = Task.await(stories_task)

    headers = Mapping.StoryMapping.col_headers(epic_data)
    story_map = Mapping.StoryMapping.stories_by_column_label(headers, story_data)

    the_map = [headers: headers, stories: story_map]
    
    # combine headers and stories into a story map
    #    {:reply, {:error, "not fully implemented"}, state}
    {:reply, {:ok, the_map}, state}
  end
  


  #
  # Private
  #
  

end
