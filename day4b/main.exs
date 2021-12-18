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

    # doing reduce on each grid (row format and column format
    # ==> [ [ A, B, C, D ], [ A, C, B, D ] ]
    lastGrid = Enum.reduce_while(numbers, gridsLine, &multiple_bingo_reducer/2)
               |> IO.inspect

    Enum.reduce_while(numbers, lastGrid, &one_bingo_reducer/2)
  end
  # result = sum(left numbers) * lastCall
  # exemple => 148 * 13 = 1924

  def multiple_bingo_reducer(number, grids) do
    # remove number
    updatedGrids = grids
                   |> Enum.map(fn grid -> remove_number(number, grid) end)
                   |> Enum.filter(fn grid -> check_if_win(grid) == false end)

    if length(updatedGrids) > 1 do
      {:cont, updatedGrids}
    else
      {:halt, List.first(updatedGrids)}
    end
  end

  def one_bingo_reducer(number, grid) do
    # remove number
    updatedGrid = remove_number(number, grid)
    # check if chunk empty
    if check_if_win(updatedGrid) do
      total = updatedGrid
              |> Enum.filter(fn x -> x != nil end)
              |> Enum.sum
      {:halt, number * total}
    else
      {:cont, updatedGrid}
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
    check_if_line_win(grid) || check_if_col_win(grid)
  end

  def check_if_line_win(gridLine) do
    gridLine
    |> Enum.chunk_every(5)
    |> Enum.any?(fn line -> Enum.all?(line, fn x -> x == nil end) end)
  end

  def check_if_col_win(gridLine) do
    gridLine
    |> Enum.chunk_every(5)
    |> Enum.zip_reduce([], fn elements, acc -> acc ++ elements end)
    |> check_if_line_win
  end

end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
