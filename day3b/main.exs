defmodule Main do

  def run(file) do
    lines = File.read!(Path.join(__DIR__, file))
            |> String.split("\n", trim: true)
    limit = length(lines) / 2

    values = lines
             |> Enum.map(fn x -> String.split(x, "", trim: true) end)
             |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
             |> IO.inspect

    oxygenGenerator = reduce_most_common(values, [], 1, 0)
                      |> IO.inspect
                      |> transform_to_integer

    co2Scrubber = reduce_most_common(values, [], 0, 1)
                  |> IO.inspect
                  |> transform_to_integer

    oxygenGenerator * co2Scrubber

  end
  # exemple => 230

  def reduce_most_common(values, acc, mostCommon, leastCommon) do
    if length(values) == 1 do
      acc ++ List.first(values)
    else
      limit = length(values) / 2
      bit = values
            |> Enum.map(&List.first/1)
            |> Enum.sum
            |> replace_to_bit(limit, mostCommon, leastCommon)

      leftValues = values
                   |> Enum.filter(fn x -> List.first(x) == bit end)
                   |> Enum.map(fn [head | tail] -> tail end)
                   |> IO.inspect
      reduce_most_common(leftValues, acc ++ [bit], mostCommon, leastCommon)
    end
  end

  def transform_to_integer(values) do
    values
    |> Enum.join()
    |> Integer.parse(2)
    |> elem(0)
    |> IO.inspect
  end

  def replace_to_bit(value, limit, mostCommon, leastCommon) do
    if value >= limit do
      mostCommon
    else
      leastCommon
    end
  end
end

Main.run("input.txt")
|> IO.inspect
Main.run("exemple.txt")
|> IO.inspect
