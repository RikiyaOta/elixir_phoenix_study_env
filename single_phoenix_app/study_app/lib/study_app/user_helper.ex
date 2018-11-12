defmodule StudyApp.UserHelper do
  
  alias StudyApp.Repo
  alias StudyApp.User

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
