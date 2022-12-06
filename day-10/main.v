import os

fn main() {
	path := './input.txt'
	lines := os.read_lines(path) or {
		println("Error reading file, quitting...")
		return
	}
	for line in lines {
		println(line)
	}
}
