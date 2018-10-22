defmodule StudyApp.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table "users" do
      add :email, :string, size: 64, null: false
      add :password, :string, size: 64, null: false
      add :name, :string, size: 64, null: false
    end

    create index("users", [:email], unique: true)
  end
end
