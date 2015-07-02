use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :trackermapper, Trackermapper.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :trackermapper, Trackermapper.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: System.get_env("DATABASE_MYSQL_USERNAME") || "root",
  password: System.get_env("DATABASE_MYSQL_PASSWORD") || "",
  database: System.get_env("DATABASE_NAME_TEST") || "test_db",
  port:     3306,
  size: 1 # Use a single connection for transactional tests
