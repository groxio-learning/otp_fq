defmodule Slots.Board do
  defstruct solution: [1, 2, 3, 4], guesses: []
  def new, do: __struct__()
  def add_guess(%{guesses: guesses}=board , guess) do
    %{ board | guesses: [guess | guesses]}
  end
end
