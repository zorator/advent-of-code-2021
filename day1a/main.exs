# values = [199, 200, 208, 210]
values = File.read!(Path.join(__DIR__, "input.txt"))
         |> String.split("\n", trim: true)
         |> Enum.map(&String.to_integer/1)

values
|> Enum.chunk_every(2, 1, :discard)
  # [[199, 200], [200, 208], [208, 210]]
|> Enum.count(fn [a, b] -> a < b end)
  # 3
|> IO.inspect

# exemple => 7
