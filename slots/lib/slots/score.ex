defmodule Slots.Score do
	defstruct white: 0, red: 0
	#def new, do: __struct__()
	def new(answer, guess) do
		reds = reds(answer, guess)
		whites = total(answer) - reds - not_in_list(answer, guess)
		__struct__(white: whites, red: reds)
	end
	defp total(answer), do: length(answer)
	defp not_in_list(answer, guess) do
		(answer -- guess) |> Enum.count
	end
	defp reds(answer,guess) do
		reds =
			answer
			|> Enum.zip(guess)
			|> Enum.count(fn {x, y} -> x == y end)
	end
	def render(%{ white: white, red: red }) do
		String.duplicate("R", red) <> String.duplicate("W", white)
	end
	def show_score(answer, guess), do: new(answer, guess) |> render()
end
