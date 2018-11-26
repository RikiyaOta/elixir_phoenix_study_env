defmodule StudyApp.Tweet do
  use StudyApp.Schema

  import Ecto.Changeset

  alias StudyApp.User
  alias StudyApp.Tweet
  alias StudyApp.UserTweet
  alias StudyApp.TweetDetail

  schema "tweets" do
    field :content, :string
    field :created_by, :binary_id
    field :modified_by, :binary_id

    belongs_to :user, User
    many_to_many :likes, User, join_through: UserTweet
    has_one :tweet_detail, TweetDetail
  
    timestamps()
  end

  def changeset(tweet, attrs \\ %{}) do
    tweet
    |> cast(attrs, [:content, :created_by, :modified_by, :user_id])
    |> validate_required([:content, :created_by, :modified_by, :user_id])
    |> assoc_constraint(:user)
  end

  def changeset_with_tweet_detail(tweet, attrs) do
    tweet
    |> Tweet.changeset(attrs)
    |> cast_assoc(:tweet_detail, with: &TweetDetail.changeset/2)
  end
end
