defmodule StudyApp.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      use Timex
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [inserted_at: :created_at, updated_at: :modified_at, type: :utc_datetime, autogenerate: {Timex, :now, ["UTC"]}]
    end
  end
end
