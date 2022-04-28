defmodule Slots.Board do
  alias Slots.Score
  # Enum.map(board.guesses, &render_row/1)
  # Enum.map(board.guesses, &render_row(answer, &1))
  defstruct solution: [1, 2, 3, 4], guesses: []
  def new, do: __struct__()
  def add_guess(%{guesses: guesses}=board , guess) do
    %{ board | guesses: [guess | guesses]}
  end
  def render_row(answer, guess) do
    "#{inspect guess} | #{Score.show_score(answer, guess)}"
  end
  def render(board) do
    """
    #{render_rows(board)}
    #{render_status(board)}
    """
  end
  def render_rows(board) do
    Enum.map(board.guesses, &render_row(board.solution, &1))
    |> Enum.join("\n")
  end
  def render_status(board) do
    # cond do
    #  won?(board) -> :won
    #   lost?(board) -> :lost
    #   true -> :playing
    # end


    cond do
      won?(board) -> :won
      lost?(board) -> :lost
      true -> :playing
    end
  end

  def won?(%{solution: s, guesses: [s|_]}), do: true
  def won?(%{solution: _, guesses: _}), do: false
  def lost?(board) do
    guesses_length =
			board.guesses
			|> length

    lost = guesses_length > 4
  end

end
