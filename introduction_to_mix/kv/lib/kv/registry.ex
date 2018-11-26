defmodule KV.Registry do
  use GenServer

  alias KV.Bucket

  #Client API
  
  def start_link(opts) do
    server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, server, opts)
  end

  def lookup(server, name) do
    case :ets.lookup(server, name) do
      [{^name, pid}] -> {:ok, pid}
      [] -> :error
    end
    #GenServer.call(server, {:lookup, name})
  end

  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  def stop(server) do
    GenServer.stop(server)
  end

  # Server Callbacks
  
  def init(table) do
    names = :ets.new(table, [:named_table, read_concurrency: true])
    refs = %{}
    {:ok, {names, refs}}
  end

  def handle_call({:lookup, name}, _from, {names, _refs} = state) do
    {:reply, Map.fetch(names, name), state}
  end

  def handle_cast({:create, name}, {names, refs} = state) do
    case lookup(names, name) do
      {:ok, pid} -> {:noreply, state}
      :error -> 
        {:ok, pid} = DynamicSupervisor.start_child(BucketSupervisor, Bucket)
        ref = Process.monitor(pid)
        refs = Map.put(refs, ref, name)
        :ets.insert(names, {name, pid})
        {:noreply, {names, refs}}
    end

    #if Map.has_key?(names, name) do
    #  {:noreply, state}
    #else
    #  {:ok, bucket} = DynamicSupervisor.start_child(BucketSupervisor, Bucket)
    #  ref = Process.monitor(bucket)
    #  refs = Map.put(refs, ref, name)
    #  names = Map.put(names, name, bucket)
    #  {:noreply, {names, refs}}
    #end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    :ets.delete(names, name)
    {:noreply, {names, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
