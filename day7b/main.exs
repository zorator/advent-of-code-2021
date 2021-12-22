require Integer

defmodule Main do

  def run(file) do

    positions = File.read!(Path.join(__DIR__, file))
                |> String.split([",", "\n"], trim: true)
                |> Enum.map(&String.to_integer/1)
                |> IO.inspect

    mediums_range = positions
                    |> compute_mediums_range
                    |> IO.inspect

    mediums_range
    |> Enum.map(fn medium -> total_fuel(positions, medium) end)
    |> Enum.min

  end
  # exemple 16,1,2,0,4,2,7,1,2,14 => 5 best place => 168 fuel

  def compute_mediums_range(positions) do
    medium = positions
             |> Enum.sum
             |> Kernel./(Enum.count(positions))
    [Kernel.floor(medium), Kernel.round(medium)]
  end

  def total_fuel(positions, medium)do
    positions
    |> Enum.map(fn position -> fuel(position, medium) end)
    |> Enum.sum
  end

  def fuel(from, to)do
    moveCount = abs(from - to)
    0..moveCount
    |> Enum.sum
  end

end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
