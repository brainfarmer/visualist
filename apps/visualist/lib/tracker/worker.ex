defmodule Tracker.Worker do
@moduledoc """
Provides Pivotal Tracker API functions
"""
  alias HTTPoison

  @base_url "https://www.pivotaltracker.com/services/v5/projects/"
  @type entity_type :: :epics | :stories
  
  @doc"""
  Return epics and stories
  """
  @spec get_epics_and_stories(integer, String.t) :: {:ok, [...]} | :error
  def get_epics_and_stories(project_id, api_token) do
    epics_results = get_backlog_data(:epics, project_id, api_token)
    stories_results = get_backlog_data(:stories, project_id, api_token)

    case {epics_results, stories_results} do
      { {:ok, epics}, {:ok, stories} } ->
	{:ok, %{epics: epics, stories: stories}}
      _ ->
	:error
    end
  end
  

  def get_stories(project_id, api_token) do
    stories = get_backlog_data(:stories, project_id, api_token)
    case stories do
      {:ok, _} -> {:ok, %{stories: stories}}
      _        ->
	:error
      end
  end

  def get_epics(project_id, api_token) do
    epics = get_backlog_data(:epics, project_id, api_token)
    case epics do
      {:ok, _} -> {:ok, %{epics: epics}}
      _        -> :error
    end
  end
  
	    
	    

  
  @spec get_backlog_data(entity_type, integer, String.t) :: {:ok, [...]} | :error
  defp get_backlog_data(entity_type, project_id, api_token) do
    headers = ["x-trackertoken": get_api_token()]
    url_for(entity_type)
      |> HTTPoison.get(headers)
      |> parse_response
  end

  
  @spec url_for(:atom) :: String.t
  defp url_for(:epics) do
    @base_url <> "#{get_project_id()}/epics"
  end

  
  @spec url_for(:atom) :: String.t
  defp url_for(:stories) do
    @base_url <> "#{get_project_id()}/stories"
  end

  
  defp get_project_id do
    # Temporarily use Visualist_test project for development
    "1389518"
  end

  
  defp get_api_token do
    # test token (jagile)
    "aa6c95ad3b28fa8520fa75b298a533f4"
  end

  
  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    parsed_response = body |> JSON.decode!
    {:ok, parsed_response}
  end

  
  defp parse_reponse(_) do
    :error
  end
  
    
end
