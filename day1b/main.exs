values = File.read!(Path.join(__DIR__, "input.txt"))
         |> String.split("\n", trim: true)
         |> Enum.map(&String.to_integer/1)


values
|> Enum.chunk_every(3, 1, :discard)
|> Enum.map(&Enum.sum/1)
|> Enum.chunk_every(2, 1, :discard)
|> Enum.count(fn [a, b] -> a < b end)
|> IO.inspect

# exemple => 5
