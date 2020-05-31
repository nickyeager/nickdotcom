defmodule Nickdotcom.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
      extensions: [PowResetPassword, PowEmailConfirmation, PowInvitation]

  alias Nickdotcom.{Repo, Users.User}
  use Arc.Ecto.Schema

  @spec changeset(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> cast_attachments(attrs, [:avatar_url])
    |> pow_extension_changeset(attrs)
  end

  schema "users" do
    field :role, :string, null: false, default: "user"
    field :avatar_url, NickdotcomWeb.Avatar.Type
    has_many :posts, Nickdotcom.Articles.Post
    pow_user_fields()

    timestamps()
  end

  @spec changeset_role(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(user admin))
  end

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end

  def upload_directory do
    Application.get_env(:nickdotcom, :uploads_directory)
  end

  def local_path(id, filename) do
    [upload_directory(), "#{id}-#{filename}"]
    |> Path.join()
  end
end
