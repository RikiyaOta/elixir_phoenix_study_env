defmodule StudyApp.Tweet do
  use StudyApp.Schema

  import Ecto.Changeset

  alias StudyApp.User
  alias StudyApp.UserTweet

  schema "tweets" do
    field :content, :string
    field :created_by, :binary_id
    field :modified_by, :binary_id

    belongs_to :user, User
    many_to_many :likes, User, join_through: UserTweet
  
    timestamps()
  end

  def changeset(tweet, attrs \\ %{}) do
    tweet
    |> cast(attrs, [:content, :created_by, :modified_by, :user_id])
    |> validate_required([:content, :created_by, :modified_by, :user_id])
    |> assoc_constraint(:user)
  end
end
