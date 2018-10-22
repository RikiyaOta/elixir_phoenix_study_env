defmodule StudyApp.UserTweet do
  use StudyApp.Schema

  import Ecto.Changeset

  alias StudyApp.User
  alias StudyApp.Tweet

  schema "users_tweets" do
    field :created_by, :binary_id
    timestamps()

    belongs_to :user, User
    belongs_to :tweet, Tweet
  end

  def changeset(user_tweet, attrs \\ %{}) do
    user_tweet
    |> cast(attrs, [:user_id, :tweet_id, :created_by])
    |> validate_required([:user_id, :tweet_id, :created_by])
    |> assoc_constraint(:user)
    |> assoc_constraint(:tweet)
    |> unique_constraint(:user, name: :users_tweets_user_id_tweet_id_index)
  end
end
