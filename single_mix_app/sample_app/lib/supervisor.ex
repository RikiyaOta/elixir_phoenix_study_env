defmodule SampleApp.Supervisor do
  #Automatically defines child_spec/1
  use Supervisor

  alias SampleApp.Stack

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl Supervisor
  def init(_arg) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: SampleApp.DynamicSupervisor},
      {Stack, [:hello]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

end
