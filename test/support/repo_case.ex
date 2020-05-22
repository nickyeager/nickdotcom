defmodule Nickdotcom.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Nickdotcom.Repo

      import Ecto
      import Ecto.Query
      import Nickdotcom.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Nickdotcom.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Nickdotcom.Repo, {:shared, self()})
    end

    :ok
  end
end