# values = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

values = File.read!(Path.join(__DIR__, "input.txt"))
         |> String.split("\n", trim: true)
         |> Enum.map(&String.to_integer/1)


Enum.chunk_every(values, 2, 1, :discard)
|> Enum.count(fn [a, b] -> a < b end)
|> IO.inspect

# exemple => 7
