defmodule Main do

  def run(file) do
    File.read!(Path.join(__DIR__, file))
    |> String.split("\n", trim: true)
    |> Enum.flat_map(fn line -> extract_points(line) end)
    |> Enum.frequencies
    |> Map.reject(fn {_key, val} -> val < 2 end)
    |> IO.inspect
    |> map_size


  end

  def extract_points(line) do
    [x1, y1, x2, y2] = line
                       |> String.split([",", " -> "])
                       |> Enum.map(&String.to_integer/1)
    if(x1 == x2 || y1 == y2) do
      Enum.flat_map(x1..x2, fn x -> Enum.map(y1..y2, fn y -> "#{x}-#{y}" end) end)
    else
      []
    end
  end
  #.......1..
  #..1....1..
  #..1....1..
  #.......1..
  #.112111211
  #..........
  #..........
  #..........
  #..........
  #222111....
  # exemple => 5 points > 1

end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
