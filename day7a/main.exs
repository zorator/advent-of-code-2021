require Integer

defmodule Main do

  def run(file) do

    positions = File.read!(Path.join(__DIR__, file))
                |> String.split([",", "\n"], trim: true)
                |> Enum.map(&String.to_integer/1)
                |> Enum.sort
                |> IO.inspect

    median = positions
             |> compute_median
             |> IO.inspect

    positions
    |> Enum.reduce(0, fn position, acc -> acc + abs(position - median) end)
  end
  # exemple 16,1,2,0,4,2,7,1,2,14 => 2 best place => 37 fuel

  def compute_median(positions) do
    size = Enum.count(positions)
    if(Integer.is_odd(size)) do
      # impair
      Enum.at(positions, round(size / 2))
    else
      # pair
      positions
      |> Enum.slice(trunc(size / 2), 2)
      |> Enum.sum
      |> Kernel./(2)
      |> Kernel.round
    end
  end

end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
