import std/strutils

proc readLinesFromFile(path: string): seq[string] = 
    return readFile(path).split("\n")

proc main() =
    let lines = readLinesFromFile("input.txt")
    for line in lines:
        echo line

main()