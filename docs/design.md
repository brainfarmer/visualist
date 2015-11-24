# Visualist Design

## Processes (components)

__TrackerX__  
Purpose is to interface with the Tracker API
  * Makes API calls to tracker API

__StoryMapper__  
Performs story mapping operations
  * Get stories and epics
  * Create story map

__Changes__  
Aggregates the changes in the backlog
  * Get changes for the last two weeks
  * Aggregate and format for presenting

__Workspace__  
Manage workspaces (i.e. groups of projects)
  * Create a workspace
  * Get current workspace
  * Edit a workspace
  * Delete a workspace
  * Add a project to a workspace
  * Remove a project from a workspace



## Routes
method | path | purpose
-|--|--
get|/changes/:project_id|get last two weeks change for the project
get|/changes/:workspace_id| get the last two week's changes for the workspacke
