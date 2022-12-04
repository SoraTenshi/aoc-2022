package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

read_files_from_input :: proc(path: string) -> []string {
	data, ok := os.read_entire_file(path);
	if !ok {
		return nil;
	}

	it := string(data);
	return strings.split(it, "\n");
}

section :: struct {
	min: int,
	max: int,
}

to_section :: proc(sec_val: string) -> section {
	min_and_max := strings.split(sec_val, "-");
	defer delete(min_and_max);
	
	min, _ := strconv.parse_int(min_and_max[0]);
	max, _ := strconv.parse_int(min_and_max[1]);
	return section{min, max};
}

solve :: proc(elf_section: []string) -> int {
	counter := 0;
	for line in elf_section {
		pairs := strings.split(line, ",");
		if(len(pairs) == 0) {
			return counter;
		}
		defer delete(pairs); 

		first := to_section(pairs[0]);
		second := to_section(pairs[1]);
		
		if (first.min <= second.min && first.max >= second.max)
			|| (first.min >= second.min && first.max <= second.max) {
			counter += 1;
		}
	}
	
	return counter;
}

solve2 :: proc(elf_section: []string) -> int {
	counter := 0;
	for line in elf_section {
		pairs := strings.split(line, ",");
		defer delete(pairs); 

		first := to_section(pairs[0]);
		second := to_section(pairs[1]);
		
		if(first.min <= second.max && first.max >= second.min) {
			counter += 1;
		}
	}
	
	return counter;
}


main :: proc() {
	data := read_files_from_input("input.txt");
	if data == nil {
		return;
	}
	defer delete(data);

	fmt.println("Part 1: ", solve(data));
	fmt.println("Part 2: ", solve2(data));
}
