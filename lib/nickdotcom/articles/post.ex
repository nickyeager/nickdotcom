defmodule Nickdotcom.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset
  use Timex

  schema "posts" do
    field :body, :string
    field :cover, :string
    field :published, :boolean, default: false
    field :slug, :string
    field :title, :string
    belongs_to :user, Nickdotcom.Users.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    # set the slug to be the title
    post
    |> cast(attrs, [:title, :body, :published, :cover, :user_id])
    |> slugify_title()
    |> validate_required([:title, :body, :published, :cover])
  end

  defimpl Phoenix.Param, for: Nickdotcom.Articles.Post do
    def to_param(%{id: id, slug: slug}) do
      "#{id}-#{slug}"
    end
  end

  def slugify_title(changeset) do
    title = get_field(changeset, :title)

    if !is_nil(title) do
      new_title = title
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9\s-]/, "")
      |> String.replace(~r/(\s|-)+/, "-")

      put_change(changeset, :slug, new_title)
    else
      changeset
    end
  end

  def date_format(date), do: date_format date, "%d %b %Y"

  def date_format(date = %DateTime{}, format_string) do
    DateTime.to_iso8601(date)
    |> date_formatter(format_string)
  end
  def date_format(date = %Date{}, format_string) do
    << Date.to_iso8601(date) <> "T00:00:00Z" >>
    |> date_formatter(format_string)
  end
  def date_format(_, _format), do: ""

  defp date_formatter(date, format_string) do
    date
    |> DateFormat.parse!("{ISOz}")
    |> DateFormat.format!(format_string, :strftime)
  end

end
