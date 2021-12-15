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
             |> Enum.zip_with(&Enum.sum/1)
      # sum all columns => [2, 1, 3, 2, 0]
             |> IO.inspect

    gammaRate = transform_to_integer(values, limit, 1, 0)
    epsilonRate = transform_to_integer(values, limit, 0, 1)

    gammaRate * epsilonRate

  end
  # exemple => 198

  @doc """
  Transform an array into a number based on the limit
  The limit tells us how to convert each value in the array in order to get an array of bit
  The array is then converted into an integer

  Examples

  iex> Maths.transform_to_integer([2, 1, 3, 2, 0], 1, 1, 0)
  Integer.parse('10110', 2)
  """
  def transform_to_integer(values, limit, mostCommon, leastCommon) do
    values
    |> Enum.map(fn x -> replace_to_bit(x, limit, mostCommon, leastCommon) end)
    |> Enum.join()
    |> IO.inspect
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
