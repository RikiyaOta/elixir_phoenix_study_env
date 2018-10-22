# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StudyApp.Repo.insert!(%StudyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

alias StudyApp.Repo
alias StudyApp.User
alias StudyApp.Tweet

alias Ecto.Multi

import Ecto.Query

require Logger

users_params = [
  %{
    email: "foo1@bar.com",
    password: "password",
    name: "unko"
  },
  %{
    email: "foo2@bar.com",
    password: "password",
    name: "taro"
  },
  %{
    email: "foo3@bar.com",
    password: "password",
    name: "jiro"
  }
]

users_transaction = Enum.reduce(users_params, Multi.new, fn user_params, transaction -> Multi.insert(transaction, user_params.email, User.changeset(%User{}, user_params)) end)

case Repo.transaction(users_transaction) do
  {:error, error} ->
    Logger.error inspect(error)
  {:ok, value} ->
    %{"foo1@bar.com" => user1, "foo2@bar.com" => user2, "foo3@bar.com" => user3} = value
    tweets_params = [
      %{
        content: "user1 content1",
        user_id: user1.id,
        created_by: user1.id,
        modified_by: user1.id
      },
      %{
        content: "user1 content2",
        user_id: user1.id,
        created_by: user1.id,
        modified_by: user1.id
      },
      %{
        content: "user2 content1",
        user_id: user2.id,
        created_by: user2.id,
        modified_by: user2.id
      },
      %{
        content: "user2 content2",
        user_id: user2.id,
        created_by: user2.id,
        modified_by: user2.id
      },
      %{
        content: "user3 content1",
        user_id: user3.id,
        created_by: user3.id,
        modified_by: user3.id
      }
    ]
    tweets_transaction = Enum.reduce(tweets_params, Multi.new, fn tweet_params, transaction -> Multi.insert(transaction, tweet_params.content, Tweet.changeset(%Tweet{}, tweet_params)) end )
    case Repo.transaction(tweets_transaction) do
      {:error, error2} ->
        Logger.error inspect(error2)
      {:ok, value2} ->
        Logger.info inspect(value2)
    end
end


