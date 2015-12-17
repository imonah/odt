defmodule Odt.ContactsController do
  use Odt.Web, :controller

  alias Odt.Contacts

  plug :scrub_params, "contacts" when action in [:create, :update]

  def index(conn, _params) do
    contacts = Repo.all(Contacts)
    render(conn, "index.html", contacts: contacts)
  end

  def new(conn, _params) do
    changeset = Contacts.changeset(%Contacts{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"contacts" => contacts_params}) do
    changeset = Contacts.changeset(%Contacts{}, contacts_params)

    case Repo.insert(changeset) do
      {:ok, _contacts} ->
        conn
        |> put_flash(:info, "Contacts created successfully.")
        |> redirect(to: contacts_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contacts = Repo.get!(Contacts, id)
    render(conn, "show.html", contacts: contacts)
  end

  def edit(conn, %{"id" => id}) do
    contacts = Repo.get!(Contacts, id)
    changeset = Contacts.changeset(contacts)
    render(conn, "edit.html", contacts: contacts, changeset: changeset)
  end

  def update(conn, %{"id" => id, "contacts" => contacts_params}) do
    contacts = Repo.get!(Contacts, id)
    changeset = Contacts.changeset(contacts, contacts_params)

    case Repo.update(changeset) do
      {:ok, contacts} ->
        conn
        |> put_flash(:info, "Contacts updated successfully.")
        |> redirect(to: contacts_path(conn, :show, contacts))
      {:error, changeset} ->
        render(conn, "edit.html", contacts: contacts, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contacts = Repo.get!(Contacts, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(contacts)

    conn
    |> put_flash(:info, "Contacts deleted successfully.")
    |> redirect(to: contacts_path(conn, :index))
  end
end
