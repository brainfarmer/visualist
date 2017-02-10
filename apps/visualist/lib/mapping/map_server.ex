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

    case get_backlog_data(task_sup_id, proj_id, api_token) do
      {:ok, epics: epics, stories: stories} ->
	headers = Mapping.StoryMapping.col_headers(epics)
	columns = Mapping.StoryMapping.stories_by_column_label(headers, stories)
	story_map = [headers: headers, stories: columns]
	{:reply, {:ok, story_map}, state}

      {:error, reason} ->
	{:reply, {:error, reason}, state}
    end
    
    
    # epics_task = Task.Supervisor.async(task_sup_id,
    #   fn -> Tracker.Worker.get(:epics, proj_id, api_token) end)
    # stories_task = Task.Supervisor.async(task_sup_id,
    #   fn -> Tracker.Worker.get(:stories, proj_id, api_token) end)

    # # Wait for backlog data
    # {:ok, epic_data} = Task.await(epics_task)
    # {:ok, story_data} = Task.await(stories_task)


    # headers = Mapping.StoryMapping.col_headers(epic_data)
    # story_map = Mapping.StoryMapping.stories_by_column_label(headers, story_data)

#    the_map = [headers: headers, stories: story_map]
    
    # combine headers and stories into a story map
    #    {:reply, {:error, "not fully implemented"}, state}
#    {:reply, {:ok, the_map}, state}
  end
  


  #
  # Private
  #

  
  defp get_backlog_data(task_sup_id, proj_id, api_token) do
    epics_task = Task.Supervisor.async(task_sup_id,
      fn -> Tracker.Worker.get(:epics, proj_id, api_token) end)
    stories_task = Task.Supervisor.async(task_sup_id,
      fn -> Tracker.Worker.get(:stories, proj_id, api_token) end)
   
    {:ok, epic_data} = Task.await(epics_task)
    {:ok, story_data} = Task.await(stories_task)

    {:ok, epics: epic_data, stories: story_data}
  end


  # defp generate_headers(:ok, state = %{epic_data: epics}) do
  #   headers = Mapping.StoryMapping.col_headers(epics)
  #   %{:ok, state | headers: headers}
  # end

  
  # defp generate_map_columns(:ok, state = %{headers: headers, story_data: story_data}) do
  #   columns = Mapping.StoryMapping.stories_by_column_label(headers, story_data)
  #   %{:ok, state | columns: columns}
  # end
  
			     
  # defp combine_into_story_map(:ok, state = %{headers: headers, columns: columns}) do
  #   [headers: headers, stories: story_map]
  # end


  # defp reply_story_map(:ok, story_map) do
  #   {:reply, {:ok, story_map}, state}
  # end
  
  

  # %{epics: nil, stories: nil, header: nil, column_map}
  # |> get epics_and_stories(accumulator, proj_id, api_token)
  # |> gen_column_headers(accoumulator)
  # |> gen_stories_by_column(accumulator)

  # the_map = accumolator.headers, accumulator.columns
  
  
end
