defmodule StudyAppWeb.Router do
  use StudyAppWeb, :router

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

  scope "/", StudyAppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/tweets/new/:user_id", TweetController, :new
    post "/tweets/create/:user_id", TweetController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", StudyAppWeb do
  #   pipe_through :api
  # end
end
