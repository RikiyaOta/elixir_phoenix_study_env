defmodule StudyAppWeb.UserControllerTest do
  use StudyAppWeb.ConnCase

  require Logger

  alias Ecto.UUID
  alias Ecto.Changeset
  alias StudyApp.Repo
  alias StudyApp.User
  alias StudyApp.Tweet
  alias StudyApp.TweetDetail

  test "create user, tweet and tweet_detail at the same time" do
    user_params = %{
      name: "rikiyaota",
      email: "hoge@bar.com",
      password: "password"
    }

    tweet_params = %{
      content: "unkounkounko",
      count_engagement: 0,
      created_by: UUID.generate,
      modified_by: UUID.generate
    }

    tweet_detail_params = %{
      location: "Kyoto"
    }

    tweet_array = [
      Map.put(tweet_params, :tweet_detail, tweet_detail_params)
    ]

    merged_params = user_params
                      |> Map.put(:tweets, tweet_array)

    changeset = %User{}
                |> User.changeset(merged_params)
                |> Changeset.cast_assoc(:tweets, with: &Tweet.changeset_with_tweet_detail/2)
    #|> Changeset.cast_assoc(:tweets, with: fn (t, p) -> Tweet.changeset(t, p) |> Changeset.cast_assoc(:tweet_detail, with: &TweetDetail.changeset/2) end)

    Logger.info "Changeset"
    Logger.info inspect(changeset)


    case Repo.insert(changeset) do
      {:ok, _} -> 
        assert 1 == 1
      {:error, error} ->
        Logger.error inspect(error)
        assert 1 == 0
    end
  end



end
