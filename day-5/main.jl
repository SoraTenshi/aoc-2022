function read_lines_from_file(path)
    return readlines(path)
end

function main()
    lines = read_lines_from_file("input.txt")
    for line in lines 
        println(line)
    end
end

main()
