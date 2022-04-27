defmodule Nova.Server do
  use GenServer, restart: :temporary
  alias Nova.Counter

  # Client

  def child_spec(%{name: name} = arg) do
    %{
      id: name,
      start: {__MODULE__, :start_link, [arg]}
    }
  end

  def start_link(arg) do
    IO.puts("starting server")
    GenServer.start_link(__MODULE__, arg.initial_value, name: arg.name)
  end

  def mata(pid) do
    GenServer.cast(pid, :boom)
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

  def stop(pid) do
    Supervisor.terminate_child(:sup, pid)
  end

  def increment_periodically(pid) do
    GenServer.cast(pid, :start_up)
  end

  # Server (callbacks)

  @impl true
  def init(initial_value) do
    IO.puts("received init callback")
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

  @impl true
  def handle_cast(:boom, _state) do
    raise "boom!"
  end

  def handle_cast(:start_up, state) do
    Process.send_after(self(), :periodically, 2000)
    {:noreply, state}
  end

  @impl true
  def handle_info(:periodically, state) do
    Process.send_after(self(), :periodically, 2000)
    {:noreply, Counter.inc(state)}
  end
end
