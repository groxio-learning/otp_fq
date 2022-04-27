defmodule Slots.Score do
	defstruct white: 0, red: 0
	#def new, do: __struct__()

	def new(answer, guess) do
		reds = 
			answer 
			|> Enum.zip(guess)
			|> Enum.filter(fn {x, y} -> x == y end)
			|> length

		not_in_list = 
		 (answer -- guess)
		 |> Enum.count

		total = length(answer)

		whites = total - reds - not_in_list

		__struct__(white: whites, red: reds)

	end


	def show_score(%{ white: white, red: red }) do
		String.duplicate("R", red) <> String.duplicate("W", white)
	end
end
