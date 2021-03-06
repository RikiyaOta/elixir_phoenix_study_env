defmodule SampleApp.DynamicSupervisor do
  use DynamicSupervisor

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl DynamicSupervisor
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

end
