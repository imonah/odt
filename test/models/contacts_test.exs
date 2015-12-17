defmodule Odt.ContactsTest do
  use Odt.ModelCase

  alias Odt.Contacts

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Contacts.changeset(%Contacts{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Contacts.changeset(%Contacts{}, @invalid_attrs)
    refute changeset.valid?
  end
end
