# Visualist


apps/visualist  
apps/visualist/lib/visualist

apps/story\_mapping  
apps/story\_mapping/lib/story\_mapping/templates  
apps/story\_mapping/lib/story\_mapping/users

apps/backlog\_data/lib/backlog_data/tracker

apps/visualist_web

apps/auth  
apps/auth/lib/auth

apps/admin  
apps/admin/lib/admin



# Use Cases
## Generate a Story Map

Given: `project_id, api_token, map_template, a name for the story map`

- Get Epic backlog data (concurrent task)
- Get Story backlog data (concurrent task)
- Get template definition
- **Sync**
- Generate map headers
- Generate map cells by rows
	- complete (concurrent task)
	- current (concurrent task)
	- backlog (concurrent task)
	- icebox (concurrent task)
- **Sync**



