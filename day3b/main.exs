defmodule Main do

  def run(file) do
    lines = File.read!(Path.join(__DIR__, file))
            |> String.split("\n", trim: true)
    # lines = ["00100","11110","10110"]

    limit = length(lines) / 2

    values = lines
             |> Enum.map(fn x -> String.split(x, "", trim: true) end)
             |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
      # [
      #   [0,0,1,0,0],
      #   [1,1,1,1,0],
      #   [1,0,1,1,0]
      #]
             |> IO.inspect

    oxygenGenerator = reduce_most_common(values, [], 1, 0)
                      |> IO.inspect
                      |> transform_to_integer

    # same call with mostCommon and leastCommon reversed
    co2Scrubber = reduce_most_common(values, [], 0, 1)
                  |> IO.inspect
                  |> transform_to_integer

    oxygenGenerator * co2Scrubber

  end
  # exemple => 230

  # Recursive call to get the first value matching the mostCommon bit
  def reduce_most_common(values, acc, mostCommon, leastCommon) do
    if length(values) == 1 do
      # if only one value left, we return the accumulated bits concatenated with the non processed bits
      acc ++ List.first(values)
    else
      limit = length(values) / 2
      # retrieving the most present bit in the first index of all values
      bit = values
            |> Enum.map(&List.first/1)
            |> Enum.sum
            |> replace_to_bit(limit, mostCommon, leastCommon)

      leftValues = values
                   # keeping only values which first element match the most common bit
                   |> Enum.filter(fn x -> List.first(x) == bit end)
        # cutting the first element out
                   |> Enum.map(fn [head | tail] -> tail end)
                   |> IO.inspect
      # recursive call with updated accumulator
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

  @doc """
  Transform a value into a bit given the limit

  Examples

  iex> Maths.replace_to_bit(10, 5, 1, 0)
  1
  iex> Maths.replace_to_bit(3, 5, 1, 0)
  0
  iex> Maths.replace_to_bit(10, 5, 0, 1)
  0
  iex> Maths.replace_to_bit(5, 5, 1, 0)
  1
  """
  def replace_to_bit(value, limit, mostCommon, leastCommon) do
    if value >= limit do
      mostCommon
    else
      leastCommon
    end
  end
end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
