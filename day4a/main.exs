defmodule Main do

  def run(file) do
    [sNumbers | sGrids] = File.read!(Path.join(__DIR__, file))
                          |> String.split("\n", trim: true)

    # array of all numbers to be picked
    numbers = sNumbers
              |> String.split(",", trim: true)
              |> Enum.map(&String.to_integer/1)
              |> IO.inspect

    # grids in single line format (array of 5*5 numbers)
    # ex:
    #   A  B
    #   C  D
    # => [ A, B, C, D ]
    gridsLine = sGrids
                |> Enum.join(" ")
                |> String.split(" ", trim: true)
                |> Enum.map(&String.to_integer/1)
                |> Enum.chunk_every(25)

    # previous grids + same converted in column format
    # ex: [ A, B, C, D ]
    #   A  B
    #   C  D
    # => [ A, C, B, D ]
    gridsRows = gridsLine
                |> Enum.map(
                     fn line ->
                       Enum.chunk_every(line, 5)
                       |> Enum.zip_reduce([], fn elements, acc -> acc ++ elements end)
                     end
                   )

    # doing reduce on each grid (row format and column format
    # ==> [ [ A, B, C, D ], [ A, C, B, D ] ]
    Enum.reduce_while(numbers, gridsLine ++ gridsRows, &bingo_reducer/2)
  end
  # result = sum(left numbers) * lastCall
  # exemple => 188 * 24 = 4512

  def bingo_reducer(number, grids) do
    # remove number
    updatedGrids = Enum.map(grids, fn grid -> remove_number(number, grid) end)
    # check if chunk empty
    findGrid = Enum.find(updatedGrids, &check_if_win/1)
    if findGrid != nil do
      IO.inspect(number)
      IO.inspect(findGrid)
      total = findGrid |> Enum.filter(fn x -> x != nil end) |> Enum.sum
      {:halt, number * total}
    else
      {:cont, updatedGrids}
    end
  end

  def remove_number(number, grid) do
    Enum.map(
      grid,
      fn x ->
        if x == number do
          nil
        else
          x
        end
      end
    )
  end

  def check_if_win(grid) do
    grid
    |> Enum.chunk_every(5)
    |> Enum.any?(fn chunk -> Enum.all?(chunk, fn x -> x == nil end) end)
  end

end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
