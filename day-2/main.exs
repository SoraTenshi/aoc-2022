defmodule Main do
  @symbols %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissor,

    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissor,
  }
  
  @points %{
    rock: 1,
    paper: 2,
    scissor: 3,
  
    lose: 0,
    draw: 3,
    win: 6,
  }
  
  def asTokens([:scissor, :scissor]), do: @points[:draw] + @points[:scissor]
  def asTokens([:paper, :paper]), do: @points[:draw] + @points[:paper]
  def asTokens([:rock, :rock]), do: @points[:draw] + @points[:rock]

  def asTokens([:rock, :paper]), do: @points[:win] + @points[:paper]
  def asTokens([:rock, :scissor]), do: @points[:lose] + @points[:scissor]

  def asTokens([:paper, :rock]), do: @points[:lose] + @points[:rock]
  def asTokens([:paper, :scissor]), do: @points[:win] + @points[:scissor]

  def asTokens([:scissor, :rock]), do: @points[:win] + @points[:rock]
  def asTokens([:scissor, :paper]), do: @points[:lose] + @points[:paper]

  
  def read_input_file(path) do
    File.read!(path)
      |> String.split("\n", trim: true)
  end
  
  def solve(str) do
    str
      |> Enum.map(fn l -> 
        l
          |> String.split(" ", trim: true)
          |> Enum.map(&@symbols[&1])
          |> asTokens()
        end)
        |> Enum.sum
  end
  
  def main() do
    file = read_input_file("input.txt")
    solved = solve(file)
    
    IO.puts(solved)
  end
end

Main.main
