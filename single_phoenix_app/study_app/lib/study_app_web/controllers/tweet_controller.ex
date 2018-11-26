defmodule StudyAppWeb.TweetController do
  use StudyAppWeb, :controller

  def new(conn, %{"user_id" => user_id}) do
    conn
    |> assign(:conn, conn)
    |> render("new.html")
  end

  #def create(conn, %{"user_id" => user_id, "tweet" => %{"content" => content, "tweet_detail" => %{"location" => location}}}) do
  #  
  #end

end
