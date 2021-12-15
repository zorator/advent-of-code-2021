defmodule Main do

  def run do
    values = File.read!(Path.join(__DIR__, "input.txt"))
             |> String.split("\n", trim: true)
             |> Enum.map(fn x -> String.split(x, " ") end)
             |> Enum.map(fn [command, value] -> [command, String.to_integer(value)] end)
             |> IO.inspect

    values
    |> Enum.reduce([0, 0], fn x, acc -> update_position(acc, x) end)
    |> Enum.product
  end
  # exemple => 150

  def update_position([position, depth], [command, value]) do
    case command do
      "forward" -> [position + value, depth]
      "down" -> [position, depth + value]
      "up" -> [position, depth - value]
    end
  end
end

Main.run()
|> IO.inspect
