defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  alias KV.Bucket

  setup do
    {:ok, bucket} = Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert is_nil(Bucket.get(bucket, "milk"))

    Bucket.put(bucket, "milk", 3)
    assert Bucket.get(bucket, "milk") == 3
  end

  test "delete values", %{bucket: bucket} do
    Bucket.put(bucket, "unko", 10)
    assert Bucket.delete(bucket, "unko") == 10
    assert is_nil(Bucket.get(bucket, "unko"))
  end

  test "are temporary worker" do
    assert Supervisor.child_spec(Bucket, []).restart == :temporary
  end

end
