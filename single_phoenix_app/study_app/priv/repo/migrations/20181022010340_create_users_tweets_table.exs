defmodule StudyApp.Repo.Migrations.CreateUsersTweetsTable do
  use Ecto.Migration

  def change do
    create table "users_tweets" do
      add :user_id, references(:users), null: false
      add :tweet_id, references(:tweets), null: false
      add :created_by, :binary_id, null: false
      timestamps()
    end

    create unique_index("users_tweets", [:user_id, :tweet_id])
  end
end
