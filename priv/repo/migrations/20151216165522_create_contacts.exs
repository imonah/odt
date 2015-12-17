defmodule Odt.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do

      timestamps
    end

  end
end
