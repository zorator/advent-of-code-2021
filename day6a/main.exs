defmodule Main do

  def run(file) do
    init_ages = File.read!(Path.join(__DIR__, file))
                |> String.split([",", "\n"], trim: true)
                |> Enum.map(&String.to_integer/1)
                |> IO.inspect

    1..80
    |> Enum.reduce(init_ages, &reduce_a_day/2)
    |> length

  end

  def reduce_a_day(day, ages) do
    ages
    |> Enum.flat_map(&map_a_fish/1)
  end

  def map_a_fish(age) do
    if(age == 0) do
      [6, 8]
    else
      [age - 1]
    end
  end

  # exemple 3,4,3,1,2 => 80 days => 5934

end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
