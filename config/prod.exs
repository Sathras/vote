use Mix.Config

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# VoteWeb.Endpoint.init/2 when load_from_system_env is
# true. Any dynamic configuration should be done there.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phx.digest task
# which you typically run after static files are built.
config :vote, VoteWeb.Endpoint,
  http: [port: 4005],
  url: [scheme: "https", host: "vote.fuchsberger.us", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  code_reloader: false,
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true,
  version: Application.spec(:vote, :vsn)

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :vote, Vote.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: System.get_env("DB_HOSTNAME"),
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: "vote_prod",
  pool_size: 1

# This line appears further down. Do not forget to uncomment it!
config :phoenix, :serve_endpoints, true