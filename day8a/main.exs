require Integer

defmodule Main do

  def run(file) do

    lines = File.read!(Path.join(__DIR__, file))
            |> String.split("\n", trim: true)
            |> Enum.map(fn line -> String.split(line, " | ", trim: true) end)
            |> IO.inspect

    outputs = lines
              |> Enum.map(fn [_, output] -> String.split(output, " ", trim: true) end)
              |> IO.inspect

    outputs
    |> Enum.concat
    |> Enum.map(&replaceByNumber/1)
    |> IO.inspect
    |> Enum.count(fn x -> x != nil end)

  end
  # exemple 1, 4, 7, and 8 => 26 times

  def replaceByNumber(output) do
    case String.length(output) do
      2 -> 1
      4 -> 4
      3 -> 7
      7 -> 8
      _ -> nil
    end
  end
end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
