defmodule Odt.ContactsControllerTest do
  use Odt.ConnCase

  alias Odt.Contacts
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, contacts_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing contacts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, contacts_path(conn, :new)
    assert html_response(conn, 200) =~ "New contacts"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, contacts_path(conn, :create), contacts: @valid_attrs
    assert redirected_to(conn) == contacts_path(conn, :index)
    assert Repo.get_by(Contacts, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, contacts_path(conn, :create), contacts: @invalid_attrs
    assert html_response(conn, 200) =~ "New contacts"
  end

  test "shows chosen resource", %{conn: conn} do
    contacts = Repo.insert! %Contacts{}
    conn = get conn, contacts_path(conn, :show, contacts)
    assert html_response(conn, 200) =~ "Show contacts"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, contacts_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    contacts = Repo.insert! %Contacts{}
    conn = get conn, contacts_path(conn, :edit, contacts)
    assert html_response(conn, 200) =~ "Edit contacts"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    contacts = Repo.insert! %Contacts{}
    conn = put conn, contacts_path(conn, :update, contacts), contacts: @valid_attrs
    assert redirected_to(conn) == contacts_path(conn, :show, contacts)
    assert Repo.get_by(Contacts, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    contacts = Repo.insert! %Contacts{}
    conn = put conn, contacts_path(conn, :update, contacts), contacts: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit contacts"
  end

  test "deletes chosen resource", %{conn: conn} do
    contacts = Repo.insert! %Contacts{}
    conn = delete conn, contacts_path(conn, :delete, contacts)
    assert redirected_to(conn) == contacts_path(conn, :index)
    refute Repo.get(Contacts, contacts.id)
  end
end
