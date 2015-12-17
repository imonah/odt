defmodule Odt.AboutController do
  use Odt.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end