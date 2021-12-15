# values = [199, 200, 208, 210, 200]
values = File.read!(Path.join(__DIR__, "input.txt"))
         |> String.split("\n", trim: true)
         |> Enum.map(&String.to_integer/1)

values
|> Enum.chunk_every(3, 1, :discard)
  # [[199, 200, 208], [200, 208, 210], [208, 210, 200]]
|> Enum.map(&Enum.sum/1)
  # [607, 618, 618]
|> Enum.chunk_every(2, 1, :discard)
  # [[607, 618], [618, 618]]
|> Enum.count(fn [a, b] -> a < b end)
  # 1
|> IO.inspect

# exemple => 5
