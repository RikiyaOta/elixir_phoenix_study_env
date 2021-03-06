defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  alias KV.Registry
  alias KV.Bucket

  setup context do
    _ = start_supervised!({Registry, name: context.test})
    %{registry: context.test}
  end

  test "spawns buckets", %{registry: registry} do
    assert Registry.lookup(registry, "shopping") == :error

    Registry.create(registry, "shopping")
    assert {:ok, bucket} = Registry.lookup(registry, "shopping")

    Bucket.put(bucket, "milk", 1)
    assert Bucket.get(bucket, "milk") == 1
  end

  test "remove bucket on exit", %{registry: registry} do
    Registry.create(registry, "shopping")
    {:ok, bucket} = Registry.lookup(registry, "shopping")
    Bucket.stop(bucket)
    assert Registry.lookup(registry, "shopping") == :error
  end

  test "remove bucket on crash", %{registry: registry} do
    Registry.create(registry, "shopping")
    {:ok, bucket} = Registry.lookup(registry, "shopping")

    #Stop the bucket with non-normal reason
    Agent.stop(bucket, :shutdown)
    assert Registry.lookup(registry, "shopping") == :error
  end

end
