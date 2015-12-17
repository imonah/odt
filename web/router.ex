defmodule Odt.Router do
  use Odt.Web, :router

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

  scope "/", Odt do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", AboutController, :index
    resources "/users", UserController
    resources "posts", PostController, only: [:index, :show]
    resources "comments", CommentController, except: [:delete]
    resources "/contacts", ContactsController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Odt do
  #   pipe_through :api
  # end
end
