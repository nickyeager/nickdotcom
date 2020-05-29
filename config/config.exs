# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nickdotcom,
  ecto_repos: [Nickdotcom.Repo]

# Configures the endpoint
config :nickdotcom, NickdotcomWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XUTVw5zJA/FZe6E4L+2CC3TlCktbURnsltUZ/LGmCp8F2ii6NhTC/OAwK44s90iZ",
  render_errors: [view: NickdotcomWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nickdotcom.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "I8XmyCoSJB03Q61vYmh2Ha2nyDAeD5Kc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
       md: PhoenixMarkdown.Engine

config :nickdotcom, NickdotcomWeb.Mailer,
       adapter: Bamboo.SendGridAdapter,
       api_key: "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",
       hackney_opts: [
         recv_timeout: :timer.minutes(1)
       ]

# Pow configuration
config :nickdotcom, :pow,
       user: Nickdotcom.Users.User,
       repo: Nickdotcom.Repo,
       web_module: NickdotcomWeb,
       mailer_backend: NickdotcomWeb.Mailer,
       extensions: [PowResetPassword, PowEmailConfirmation, PowInvitation],
       controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
