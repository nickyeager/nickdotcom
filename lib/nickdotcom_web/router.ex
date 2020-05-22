defmodule NickdotcomWeb.Router do
  use NickdotcomWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
      extensions: [PowResetPassword, PowEmailConfirmation, PowInvitation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :put_root_layout, {NickdotcomWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # BEGIN added for Pow
  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
         error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
         error_handler: Pow.Phoenix.AuthErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end


  scope "/", NickdotcomWeb do
    pipe_through [:browser, :not_authenticated]

    get "/", PageController, :index
    live "/gallery", GalleryLive
    live "/counter", CounterLive
  end

  scope "/", NickdotcomWeb do
    pipe_through [:browser, :protected]
  end

  scope "/api/v1", NickdotcomWeb do
    pipe_through [:api, :protected]
    get "/users", UserController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", NickdotcomWeb do
  #   pipe_through :api
  # end
end
