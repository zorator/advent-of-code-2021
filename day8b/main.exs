require Integer

defmodule Main do

  def run(file) do

    lines = File.read!(Path.join(__DIR__, file))
            |> String.split("\n", trim: true)
            |> Enum.map(fn line -> String.split(line, " | ", trim: true) end)
            |> Enum.map(fn [input, output] -> [splitAndSort(input), splitAndSort(output)] end)

    lines
    |> Enum.map(&getOutputValue/1)
    |> Enum.sum

  end
  # fdgacbe cefdb cefbgd gcbe: 8394
  # fcgedb cgb dgebacf gc: 9781
  # cg cg fdcagb cbg: 1197
  # efabcd cedba gadfec cb: 9361
  # gecf egdcabf bgf bfgea: 4873
  # gebdcfa ecba ca fadegcb: 8418
  # cefg dcbef fcge gbcadfe: 4548
  # ed bcgafe cdgba cbgef: 1625
  # gbdfcae bgc cg cgb: 8717
  # fgae cfgab fg bagce: 4315
  # Sum => 61229

  def getOutputValue([inputs, outputs]) do
    [one | [seven | [four | others]]] = inputs
                                        |> Enum.sort_by(&byte_size/1)
    [eight | leftInputs] = Enum.reverse(others)
    [s069, s235] = Enum.chunk_every(leftInputs, 3)
    [three, s25] = extract_match(s235, one, &leftContainsRight/2)
    [nine, s06] = extract_match(s069, three, &leftContainsRight/2)
    [five, [two]] = extract_match(s25, nine, &rightContainsLeft/2)
    [six, [zero]] = extract_match(s06, five, &leftContainsRight/2)

    numbersMap = %{
      zero => 0,
      one => 1,
      two => 2,
      three => 3,
      four => 4,
      five => 5,
      six => 6,
      seven => 7,
      eight => 8,
      nine => 9
    }
    outputs
    |> Enum.map(fn o -> Map.get(numbersMap, o) end)
    |> Enum.join
    |> String.to_integer
  end

  def extract_match(inputs, letter, matcher) do
    result = Enum.find(inputs, fn input -> matcher.(input, letter) end)
    [result, Enum.filter(inputs, fn input -> input != result end)]
  end

  def leftContainsRight(a, b) do
    String.split(b, "", trim: true)
    |> Enum.all?(fn l -> String.contains?(a, l) end)
  end

  def rightContainsLeft(a, b) do
    leftContainsRight(b, a)
  end

  def splitAndSort(data) do
    data
    |> String.split(" ", trim: true)
    |> Enum.map(&sortString/1)
  end

  def sortString(s)do
    s
    |> String.split("", trim: true)
    |> Enum.sort
    |> Enum.join
  end
end

IO.puts "*********** Running Exercice ***********"
Main.run("input.txt")
|> IO.inspect
IO.puts "\n*********** Running Exemple ***********"
Main.run("exemple.txt")
|> IO.inspect
