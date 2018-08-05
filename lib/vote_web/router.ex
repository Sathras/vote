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

    # Base Functionality
    get     "/", PollController, :home
    post    "/", AuthController, :create
    delete  "/", AuthController, :delete

    # Poll Functionality
    get     "/results", PollController, :index
    get     "/vote",    PollController, :new
    post    "/vote",    PollController, :create
    delete  "/results", PollController, :delete
  end
end
