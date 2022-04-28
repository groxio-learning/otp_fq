defmodule Slots.Game do
  use GenServer
  alias Slots.Board

  # Client

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def guess(name, input) do
    GenServer.call(name, {:guess, input})
    |> IO.puts()
  end

  # Server (callbacks)

  @impl true
  def init(:ok) do
    {:ok, Board.random_new()}
  end

  @impl true
  def handle_call(:read_board, _from, board) do
    {:reply, Board.render(board), board}
  end

  @impl true
  def handle_call({:guess, input}, _from, board) do
    new_board = Board.add_guess(board, input)
    {:reply, Board.render(new_board), new_board}
  end
end
