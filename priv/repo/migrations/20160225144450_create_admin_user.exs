defmodule Picty.Repo.Migrations.CreateAdminUser do
  use Ecto.Migration

  def change do
    create table(:admin_users) do
      add :username, :string
      add :password, :string

      timestamps
    end

  end
end
