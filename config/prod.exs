use Mix.Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.

# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
config :nickdotcom, NickdotcomWeb.Endpoint,
       load_from_system_env: true,
       url: [host: Application.get_env(:nickdotcom, :app_hostname), port: Application.get_env(:nickdotcom, :app_port)],
       cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# Which server to start per endpoint:
#
config :nickdotcom, NickdotcomWeb.Endpoint, server: true

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :nickdotcom, NickdotcomWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [
#         port: 443,
#         cipher_suite: :strong,
#         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#         certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#         transport_options: [socket_opts: [:inet6]]
#       ]
#
# The `cipher_suite` is set to `:strong` to support only the
# latest and more secure SSL ciphers. This means old browsers
# and clients may not be supported. You can set it to
# `:compatible` for wider support.
#
# `:keyfile` and `:certfile` expect an absolute path to the key
# and cert in disk or a relative path inside priv, for example
# "priv/ssl/server.key". For all supported SSL configuration
# options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
#
# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
#     config :nickdotcom, NickdotcomWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

#config :nickdotcom, NickdotcomWeb.Pow.Mailer,
#       adapter: Bamboo.SendGridAdapter,
#       api_key: "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",
#       hackney_opts: [
#         recv_timeout: :timer.minutes(1)
#       ]
config :nickdotcom, Nickdotcom.Repo,
       adapter: Ecto.Adapters.Postgres,
       pool_size: String.to_integer(System.get_env("POOL_SIZE") || "5"),
       ssl: true,
       url: System.get_env("DATABASE_URL"),
       show_sensitive_data_on_connection_error: true


# Finally import the config/prod.secret.exs which loads secrets
# and configuration from environment variables.
#import_config "prod.secret.exs"
