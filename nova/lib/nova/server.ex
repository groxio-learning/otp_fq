defmodule Nova.Server do
  use GenServer
  alias Nova.Counter

  # Client

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value)
  end

  def increment(pid) do
    GenServer.cast(pid, :inc)
  end

  def decrement(pid) do
    GenServer.cast(pid, :dec)
  end

  def read_state(pid) do
    GenServer.call(pid, :read)
  end

  # Server (callbacks)

  @impl true
  def init(initial_value) do
    {:ok, Counter.new(initial_value)}
  end

  @impl true
  def handle_call(:read, _from, state) do
    {:reply, Counter.message(state), state}
  end

  @impl true
  def handle_cast(:inc, state) do
    {:noreply, Counter.inc(state)}
  end

  @impl true
  def handle_cast(:dec, state) do
    {:noreply, Counter.dec(state)}
  end
end
