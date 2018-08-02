# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vote,
  ecto_repos: [Vote.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :vote, VoteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "n+OrBiQertfwWX/KUiE3NBP+r9+mVOa320V8UZj+mhKBfwE/mkd3yNRf4K5jz/io",
  render_errors: [view: VoteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Vote.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
