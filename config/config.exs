# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :uncapped,
  ecto_repos: [Uncapped.Repo]

# Configures the endpoint
config :uncapped, Uncapped.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Nr+WhXLVIWao0GZmXd3Q7p8Ga0q0Rwyv58oC7xfJp1+QGHVBal8/Jnldt4Hpt568",
  render_errors: [view: Uncapped.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Uncapped.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
