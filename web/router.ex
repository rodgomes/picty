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

  scope "/", Picty do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Picty do
    pipe_through :api
    get "/search", SearchController, :search
  end

end
