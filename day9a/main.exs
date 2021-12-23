require Integer

defmodule Main do

  def run(file) do

    lines = File.read!(Path.join(__DIR__, file))
            |> String.split("\n", trim: true)
    # line length
    lineWidth = String.length(Enum.at(lines, 0))
    values = lines
             |> Enum.join
             |> String.split("", trim: true)
             |> Enum.map(&String.to_integer/1)

    values
    |> Enum.with_index
    |> Enum.filter(fn ({x, i}) -> isLowPoint(x, i, values, lineWidth) end)
    |> Enum.map(fn ({x, _}) -> x + 1 end)
    |> Enum.sum

  end
  # low points are 2, 1, 6, and 6
  # Sum => 15

  def isLowPoint(point, index, values, lineWidth) do
    # [up, down, left, right]
    getIndexes(index, lineWidth, values)
    |> Enum.map(fn i -> getPoint(i, values) end)
    |> Enum.all?(fn p -> p > point end)
  end

  def getIndexes(index, lineWidth, values) do
    # no up if first line
    up = if index < lineWidth, do: nil, else: index - lineWidth
    # no down if last line
    down = if index >= length(values) - lineWidth, do: nil, else: index + lineWidth
    # no left if first column
    left = if rem(index, lineWidth) == 0, do: nil, else: index - 1
    # no right if last column
    right = if rem(index + 1, lineWidth) == 0, do: nil, else: index + 1

    Enum.reject([up, down, left, right], fn x -> x == nil end)
  end

  def getPoint(index, values) do
    if(0 <= index && index < length(values)) do
      Enum.at(values, index, 9)
    else
      9
    end
  end
end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
