defmodule StudyApp.TweetDetail do
  use StudyApp.Schema

  import Ecto.Changeset

  alias StudyApp.Tweet
  alias StudyApp.TweetDetail

  schema "tweet_details" do
    field :location, :string
    field :count_engagement, :integer, default: 0
    belongs_to :tweet, Tweet

    timestamps()
  end

  def changeset(%TweetDetail{} = tweet, params) do
    tweet
    |> cast(params, [:location, :count_engagement, :tweet_id])
    |> validate_required([:location, :count_engagement, :tweet_id])
  end

end
