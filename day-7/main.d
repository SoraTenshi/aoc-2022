import std.stdio, std.string, std.algorithm;

auto read_lines_from_file(string path) {
    auto file = File(path);
    return file.byLine();
}

void main() {
    auto lines = read_lines_from_file("input.txt");
    foreach(line; lines) {
        writeln(line);
    }
}
