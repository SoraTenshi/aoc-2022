mutable struct Move
    amount::Int
    from::Int
    to::Int
end

function get_stacks(input)
    stacks = split(input, "\n")
    stacks = map(x -> replace(x, "[" => "")
          |> x -> replace(x, "]" => "")
          |> x -> replace(x, "    " => "0")
          |> x -> replace(x, " " => "")
          |> x -> replace(x, "0" => " "), stacks)
    stacks = filter!(!=("123456789"), stacks)
    stacks = map(x -> split(x, "")
          |> x -> replace(x, " " => ""), stacks)
    stacks = collect(stacks)
    stacks = hcat(stacks...)
    # Yes with matrizes this doesn't work as they're overflowing...
    stacks = [stacks[i,:] for i in 1:size(stacks,1)]
    stacks = map(x -> filter(y -> !isempty(y), x), stacks)
    for (i, stack) in enumerate(stacks)
        stacks[i] = reverse(stack)
    end
    return stacks
end

function get_moves(input)
    moves = split(input, "\n")
    pop!(moves)

    regex = r"move (\d+) from (\d+) to (\d+)"
    move_data = match.(regex, moves)
    moves = []
    for data in move_data
        push!(moves, Move(parse(Int, data[1]), parse(Int, data[2]), parse(Int, data[3])))
    end

    return moves
end

function solve(stacks, moves)
    for move in moves
        while move.amount > 0
            push!(stacks[move.to], pop!(stacks[move.from]))
            move.amount -= 1
        end
    end
    
    return stacks
end

function solve2(stacks, moves)
    for move in moves
        stacker = Vector{AbstractString}()
        while move.amount > 0
            push!(stacker, pop!(stacks[move.from]))
            move.amount -= 1
        end
        
        for stack in reverse(stacker)
            push!(stacks[move.to], stack)
        end
    end

    return stacks
end

function main()
    lines = split(read("input.txt", String), "\n\n")
    moves_str = pop!(lines)
    stacks_str = pop!(lines)
    stacks = get_stacks(stacks_str)
    moves = get_moves(moves_str)
    # println(moves)
    for i in solve(deepcopy(stacks), deepcopy(moves))
        print(last(i))
    end
    println()
    for i in solve2(stacks, moves)
        print(last(i))
    end
    println()
end

main()
