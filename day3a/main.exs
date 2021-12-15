defmodule Main do

  def run(file) do
    lines = File.read!(Path.join(__DIR__, file))
            |> String.split("\n", trim: true)
    limit = length(lines) / 2

    values = lines
             |> Enum.map(fn x -> String.split(x, "", trim: true) end)
             |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
             |> Enum.zip_with(&Enum.sum/1)
             |> IO.inspect

    gammaRate = transform_to_integer(values, limit, 1, 0)
    epsilonRate = transform_to_integer(values, limit, 0, 1)

    gammaRate * epsilonRate

  end
  # exemple => 198

  def transform_to_integer(values, limit, mostCommon, leastCommon) do
    values
    |> Enum.map(fn x -> replace_to_bit(x, limit, mostCommon, leastCommon) end)
    |> Enum.join()
    |> Integer.parse(2)
    |> elem(0)
    |> IO.inspect
  end

  def replace_to_bit(value, limit, mostCommon, leastCommon) do
    if value > limit do
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
