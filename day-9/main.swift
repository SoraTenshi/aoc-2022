import Foundation

func readFileLines(fileUrl: URL) throws -> [String] {
	let fileContents = try String(contentsOf: fileUrl)
	return fileContents.components(separatedBy: .newlines)
}

func main() throws {
	let fileUrl = URL(fileURLWithPath: "./input.txt")
	let lines = try readFileLines(fileUrl: fileUrl)
	for line in lines {
		print(line)
	}
}

try main()
