defmodule StudyApp.Repo.Migrations.CreateTweetDetails do
  use Ecto.Migration

  def change do
    create table "tweet_details" do
      add :location, :string, null: false
      add :count_engagement, :integer, null: false, default: 0
      add :tweet_id, references(:tweets, on_delete: :delete_all), null: false, unique: true

      timestamps()
    end
  end
end
