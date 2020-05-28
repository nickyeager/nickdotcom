defmodule NickdotcomWeb.Mailer do
  use Pow.Phoenix.Mailer
  use Bamboo.Mailer, otp_app: :nickdotcom

  import Bamboo.Email
  require Logger

  @impl true
  def cast(%{user: user, subject: subject, text: text, html: html}) do
    new_email(
      to: user.email,
      from: "yeag123@gmail.com",
      subject: subject,
      html_body: html,
      text_body: text
    )
  end

  @impl true
  def process(email) do
    Logger.debug("E-mail sent: #{inspect email}")
    deliver_now(email)
  end
end