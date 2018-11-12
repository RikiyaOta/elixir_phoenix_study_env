defmodule StudyApp.TweetHelper do
  
  alias StudyApp.Repo
  alias StudyApp.Tweet
  
  def create_tweet(attrs) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
  end

  def update_tweet(tweet, attrs) do
    tweet
    |> Tweet.changeset(attrs)
    |> Repo.update()
  end
end
