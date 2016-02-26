defmodule Picty.Repo.Migrations.AddUniqueConstraintToUsername do
  use Ecto.Migration

  def change do
    create unique_index(:admin_users, [:username])
  end
end
