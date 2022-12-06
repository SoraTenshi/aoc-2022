def read_lines_from_path(path)
  return File.read_lines path
end

# Simple; just find the first of x which are unique.
def solve(str)
  quad_set = Set(Char).new
  str.each_char.each_slice(4).with_index do |group, index|
    group.each do |char|
      puts "I #{index} -> #{group}"
      if !quad_set.add?(char)
        break
      end
    end
    
    if quad_set.size != 4
      quad_set.clear
    else
      puts "found! #{quad_set}"
      return index * 4 + 1
    end
  end
end

# Simple; just find the first of x which are unique.
def solve2(str)
  quad_set = Set(Char).new
  str.each_char.with_index do |char, index|
    puts "I #{index} -> #{char}"
    if !quad_set.add?(char)
      quad_set.clear
    end
    
    if quad_set.size == 14
      puts "found! #{quad_set}"
      return index + 1
    end
  end
end

def main
  lines = read_lines_from_path "input.txt"
  lines.each do |line|
    puts solve line
    puts solve2 line
  end
end

main