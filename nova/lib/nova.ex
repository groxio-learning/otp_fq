defmodule Nova do
  def new() do
    %{}
  end

  def add_key(acc, key) do
    acc
    |> Map.put(key, 0)
  end

  # This is an accumulator
  def inc_key(acc, key) do
    if Map.keys(acc) |> Enum.member?(key) do
      Map.get_and_update(acc, key, fn current_value ->
        {:ok, current_value + 1}
      end)
      |> elem(1)
    else
      acc
    end
  end

  def message(acc) do
    acc
    |> Enum.map(fn {key, value} ->
      "The count of #{key} is #{value}!"
    end)
  end

end
