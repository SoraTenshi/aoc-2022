defmodule Main do
  def read_input_file(path) do
    File.stream!(path)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&IO.inspect/1)
      |> Stream.run
  end
  
  def main() do
    read_input_file("input.txt")
      |> Stream.map(&IO.puts/1)
  end
end

Main.main
