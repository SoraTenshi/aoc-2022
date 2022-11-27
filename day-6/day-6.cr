def read_lines_from_path(path)
  return File.read_lines path
end

def main
  lines = read_lines_from_path "input.txt"
  lines.each do |line|
    puts line
  end
end

main