defmodule Nova.Server do
  use GenServer
  alias Nova.Counter

  # Client

  def child_spec(arg) do
    %{
      id: arg.name,
      start: {__MODULE__, :start_link, [arg]}
    }
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg.initial_value, name: arg.name)
  end

  def increment(counter_name) do
    GenServer.cast(counter_name, :inc)
  end

  def decrement(counter_name) do
    GenServer.cast(counter_name, :dec)
  end

  def read_state(counter_name) do
    GenServer.call(counter_name, :read)
  end

  # Server (callbacks)

  @impl true
  def init(initial_value) do
    {:ok, Counter.new(initial_value)}
  end

  @impl GenServer
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
