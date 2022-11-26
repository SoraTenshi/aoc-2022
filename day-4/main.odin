package main

import "core:fmt"
import "core:os"
import "core:strings"

read_files_from_input :: proc(path: string) -> []string {
	data, ok := os.read_entire_file(path);
	if !ok {
		return nil;
	}

	it := string(data);
	return strings.split(it, "\n");
}

main :: proc() {
	data := read_files_from_input("input.txt");
	if data == nil {
		return;
	}
	defer delete(data);

	for line in data {
		fmt.println(line);
	}
}