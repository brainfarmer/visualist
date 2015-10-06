use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :visualist, Visualist.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :visualist, Visualist.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :visualist, Visualist.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "visualist_dev",
  pool_size: 10 # The amount of database connections in the pool

# Interim test API tokens until we get a way to manage users
config :visualist, test_api_token: "aa6c95ad3b28fa8520fa75b298a533f4"
