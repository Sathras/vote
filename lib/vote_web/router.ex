defmodule VoteWeb.Router do
  use VoteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug VoteWeb.Auth
  end

  scope "/", VoteWeb do
    pipe_through :browser
    get "/", PageController, :index
    post "/", AuthController, :create
    delete "/", AuthController, :delete
  end
end
