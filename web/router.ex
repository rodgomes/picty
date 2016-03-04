defmodule Picty.Router do
  use Picty.Web, :router
  #alias Picty.Plug.AdminAuthenticate

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_authenticate do
    plug Picty.Plugs.AdminAuthenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_layout do
    plug :put_layout, {Picty.LayoutView, :admin}
  end

  scope "/", Picty do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", PageController, :about
  end

  scope "/api", Picty do
    pipe_through :api

    get "/search.json", SearchController, :search
    get "/locations.json", LocationController, :suggested_locations
  end

  scope "/admin", Picty do
    pipe_through [:browser, :admin_layout]

    # resources "/locations", LocationController

    get "/signin", SessionController, :signin
    get "/signout", SessionController, :signout
    post "/authenticate", SessionController, :authenticate

  end

  scope "/admin", Picty do
    pipe_through [:browser, :admin_layout, :admin_authenticate]
    resources "/locations", LocationController
  end

end
