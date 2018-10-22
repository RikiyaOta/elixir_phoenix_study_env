defmodule StudyApp.Repo.Migrations.CreateTweetsTable do
  use Ecto.Migration

  def change do
    create table "tweets" do
      add :content, :text, null: false
      add :created_by, :binary_id, null: false
      add :modified_by, :binary_id, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
