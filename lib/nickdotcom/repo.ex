defmodule Nickdotcom.Repo do
  use Ecto.Repo,
    otp_app: :nickdotcom,
    adapter: Ecto.Adapters.Postgres
end
