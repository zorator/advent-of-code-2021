defmodule Main do

  def run(file, days) do

    initAgesCount = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    # list containing the count of fish by age, age is the index
    agesCount = File.read!(Path.join(__DIR__, file))
                |> String.split([",", "\n"], trim: true)
                |> Enum.map(&String.to_integer/1)
                |> IO.inspect
                |> Enum.reduce(initAgesCount, &reduceAgesCount/2)
                |> IO.inspect

    # 0, 1, 1, 2, 1, 0, 0, 0, 0

    1..days
    |> Enum.reduce(agesCount, &reduceDays/2)
    |> Enum.sum

  end
  # exemple 3,4,3,1,2 => 80 days => 5934
  # exemple 3,4,3,1,2 => 256 days => 26984457539

  def reduceAgesCount(age, agesCount) do
    List.update_at(agesCount, age, fn a -> a + 1 end)
  end

  @doc """
  Update the array if ages count as if a day passed
  The fish count in age 6 is incremented by the number of "day 0" fishes
  The fish count in age 8 is also incremented by the same amount

  The list is shifted, with new born added at the end, and parents added to "age 6" => index 6

  Examples

  iex> reduceDays(_, [3, 4, 1, 1, 1, 1, 1, 0, 0])
  [4, 1, 1, 1, 1, 1 + 3, 0, 0, 3]
  """
  def reduceDays(day, agesCount) do
    [newCount | others] = agesCount
    others = List.update_at(others, 6, fn a -> a + newCount end)
    others ++ [newCount]
  end

end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt", 256)
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt", 80)
|> IO.inspect
Main.run("exemple.txt", 256)
|> IO.inspect
