# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the namespace used by Phoenix generators
config :web,
  app_namespace: Visualist.Web

# Configures the endpoint
config :web, Visualist.Web.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "JaUWMUD+uNxGY0mBH6XuUFzxw3yT0iHrHvVT3xzNesRw3dNsW0HqpyQD4K6Mu6I2",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Visualist.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
