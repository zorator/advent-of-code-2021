defmodule Main do

  def run(file) do
    values = File.read!(Path.join(__DIR__, file))
             |> String.split("\n", trim: true)
             |> Enum.map(fn x -> String.split(x, " ") end)
             |> Enum.map(fn [command, value] -> [command, String.to_integer(value)] end)
             |> IO.inspect

    [position, depth, aim] = values
                             |> Enum.reduce([0, 0, 0], &reduce_position/2)
    position * depth
  end
  # exemple => 900

  def reduce_position([command, value], [position, depth, aim]) do
    case command do
      "forward" -> [position + value, depth + aim * value, aim]
      "down" -> [position, depth, aim + value]
      "up" -> [position, depth, aim - value]
    end
  end
end

Main.run("input.txt")
|> IO.inspect
Main.run("exemple.txt")
|> IO.inspect
