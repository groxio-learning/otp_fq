defmodule Nova.Service do
  alias Nova.Counter

  def start(string) do
    spawn(fn -> string |> Counter.new() |> run() end)
  end

  def run(counter) do
    counter |> listen() |> run()
  end

  def listen(counter) do
    receive do
      :inc ->
        Counter.inc(counter)

      :dec ->
        Counter.dec(counter)

      {:read, from} ->
        send(from, Counter.message(counter))
        counter
    end
  end
end
