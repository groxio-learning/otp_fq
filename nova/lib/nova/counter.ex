defmodule Nova.Counter do
  @moduledoc """
  Documentation for `Counter`.
  """

  @doc """
   New - creates the new map with the string as an integer

  """
  def new(input) when is_binary(input) do
    %{count: String.to_integer(input)}
  end

  @doc """
   Inc - increments the count in the map

  """
  def inc(acc) do
    %{count: Map.get(acc, :count) + 1}
  end

  @doc """
   Dec - decrements the count in the map

  """
  def dec(acc) do
    %{count: Map.get(acc, :count) - 1}
  end

  @doc """
   Message - prints out the count in the map

  """
  def message(acc) do
    "The count is #{acc.count}"
  end
end
