defmodule KV.Supervisor do
  use Supervisor

  alias KV.Registry

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {DynamicSupervisor, name: BucketSupervisor, strategy: :one_for_one},
      {Registry, name: Registry}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
