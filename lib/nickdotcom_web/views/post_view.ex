defmodule NickdotcomWeb.PostView do
  use NickdotcomWeb, :view
  require Earmark

  def markdown(body) do
    body
    |> Earmark.as_html
  end

end
