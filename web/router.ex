defmodule Picty.Router do
  use Picty.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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
    resources "/locations", LocationController

    get "/signin", SessionController, :signin
    post "/authenticate", SessionController, :authenticate

  end

end
