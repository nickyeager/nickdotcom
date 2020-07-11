import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
app_port = "4000"
app_hostname = System.fetch_env!("HOSTNAME")
db_user = System.fetch_env!("PGUSER")
db_password = System.fetch_env!("PGPASSWORD")
db_host = System.fetch_env!("PGHOST")
db_name = System.fetch_env!("PGDATABASE")
db_port = System.fetch_env!("PGPORT")

config :nickdotcom, NickdotcomWeb.Endpoint,
       server: true,
       http: [port: {:system, "PORT"}], # Needed for Phoenix 1.2 and 1.4. Doesn't hurt for 1.3.
       url: [host: nil, port: 443]

config :nickdotcom,
       app_port: app_port

config :nickdotcom,
       app_hostname: app_hostname

# Configure your database
config :nickdotcom, Nickdotcom.Repo,
       username: db_user,
       password: db_password,
       database: db_name,
       hostname: db_host,
       port: db_port |> String.to_integer,
       pool_size: 10

config :nickdotcom,
       ecto_repos: [Nickdotcom.Repo]