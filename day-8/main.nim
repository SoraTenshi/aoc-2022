import strutils, strformat, sequtils, sugar, algorithm

proc readLinesFromFile(path: string): seq[string] = 
    return readFile(path).strip().splitLines()

proc toGrid(input: seq[string]): seq[seq[int]] = 
    var grid: seq[seq[int]]
    for row in input:
        var rowSplit: seq[int] = @[]
        for r in row:
            rowSplit.add(parseInt(fmt"{r}"))
        grid.add(rowSplit)
    return grid

proc solve(input: seq[string]): int = 
    let grid = toGrid(input)
    let height = grid.len
    let width = grid[0].len
    var visible = newSeq[int]()

    for col in 0..<width:
        for row in 0..<height:
            let current = grid[row][col]
            # All outer tree are visible
            if row == 0 or col == 0 or row == height-1 or col == width-1:
                visible.add(current)
                continue
    
            # View from left side
            if (0..<col).toSeq().all(c => grid[row][c] < current):
                visible.add(current)
                continue

            # View from up side
            if (0..<row).toSeq().all(r => grid[r][col] < current):
                visible.add(current)
                continue

            # View from right side
            if (row+1..<height).toSeq().all(r => grid[r][col] < current):
                visible.add(current)
                continue

            # View from down side
            if (col+1..<width).toSeq().all(c => grid[row][c] < current):
                visible.add(current)
                continue

    return visible.len

proc solve2(input: seq[string]): int = 
    let grid = toGrid(input)
    let height = grid.len
    let width = grid[0].len
    var products = newSeq[int]()

    for col in 0..<width:
        for row in 0..<height:
            let current = grid[row][col]
            var (u, l, r, d) = (0, 0, 0, 0)

            # View from up side
            for sameColU in countdown(col-1, 0):
                u += 1
                if current <= grid[row][sameColU]:
                    break

            # View from left side
            for sameRowL in countdown(row-1, 0):
                l += 1
                if current <= grid[sameRowL][col]:
                    break

            # View from right side
            for sameRowR in (row+1..<height):
                r += 1
                if current <= grid[sameRowR][col]:
                    break
                

            # View from down side
            for sameColD in (col+1..<width):
                d += 1
                if current <= grid[row][sameColD]:
                    break

            products.add(u * d * l * r)
    sort(products, Descending)
    return products[0]

proc main() =
    let lines = readLinesFromFile("input.txt")
    echo("Part 1: ", solve(lines))
    echo("Part 2: ", solve2(lines))

proc test() =
    let input: seq[string] = @[
        "30373",
        "25512",
        "65332",
        "33549",
        "35390",
    ]
    let output = solve2(input)
    echo "Test output: ", output
    assert output == 8

main()
test()