# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :study_app,
  ecto_repos: [StudyApp.Repo]

# Configures the endpoint
config :study_app, StudyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "POjsgCCXXFQbtTDBwfCW8yHXsuWjY+qdelgr+/TUzRErArUbbRHfGqI20r76z63p",
  render_errors: [view: StudyAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StudyApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
