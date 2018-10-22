defmodule StudyApp.User do
  use StudyApp.Schema

  import Ecto.Changeset

  alias StudyApp.Tweet
  alias StudyApp.UserTweet

  schema "users" do
    field :email, :string
    field :password, :string
    field :name, :string

    has_many :tweets, Tweet
    many_to_many :likes, Tweet, join_through: UserTweet
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :password, :name])
    |> validate_required([:email, :password, :name])
    |> validate_length(:email, max: 64)
    |> validate_length(:password, max: 64)
    |> validate_length(:name, max: 64)
    |> unique_constraint(:email)
  end
end
