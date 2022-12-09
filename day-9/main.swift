import Foundation

extension String {
	func trim() -> String {
		return trimmingCharacters(in: CharacterSet.whitespaces)
	}
}

struct Point: CustomStringConvertible, Equatable, Hashable {
	var x: Int
	var y: Int
	
	var description: String {
		get {
			return "X: \(x) Y: \(y)"
		}
	}
}

struct Rope: CustomStringConvertible {
	var head: Point
	var tail: Point
	
	var description: String {
		get {
			return "Head: {\(head)} Tail: {\(tail)}"
		}
	}
	
	func touchesY() -> Bool {
		return abs(head.y - tail.y) < 2
	}
	
	func touchesX() -> Bool {
		return abs(head.x - tail.x) < 2
	}
	
	func touches() -> Bool {
		return touchesX() && touchesY()
	}
}

func readFileLines(fileUrl: URL) throws -> [String] {
	let fileContents = try String(contentsOf: fileUrl)
	return fileContents.trim().components(separatedBy: .newlines).filter { $0 != "" }
}

func solve(motions: [String]) -> Int {
	var grids: Set<Point> = [Point.init(x: 0, y: 0)]
	var rope = Rope.init(
		head: Point.init(x: 0, y: 0),
		tail: Point.init(x: 0, y: 0)
	)

	for motion in motions {
		let split = motion.split(separator: " ")
		let steps = Int(String(split[1]))!
		for _ in 1...steps {
			switch split[0] {
				case "U": rope.head.x -= 1
				case "D": rope.head.x += 1
				case "L": rope.head.y -= 1
				case "R": rope.head.y += 1
				default: fatalError("wrong input")
			}
			
			if abs(rope.head.y - rope.tail.y) > 1 ||
				abs(rope.head.x - rope.tail.x) > 1 {
				let movement = Point.init(
					x: rope.head.x - rope.tail.x, 
					y: rope.head.y - rope.tail.y
				)
				rope.tail.x += movement.x != 0 ? movement.x / abs(movement.x) : 0
				rope.tail.y += movement.y != 0 ? movement.y / abs(movement.y) : 0
			}

			// print("Rope: \(rope)")
			grids.insert(rope.tail)
		}
	}
	return grids.count
}

func solve2(motions: [String]) -> Int {
	var tails: [Point] = []
	for _ in 1...9 {
		tails.append(Point.init(x: 0, y: 0))
	}
	var grids: Set<Point> = Set()

	for motion in motions {
		let split = motion.split(separator: " ")
		let steps = Int(String(split[1]))!
		for _ in 1...steps {
			switch split[0] {
				case "U": tails[0].x -= 1
				case "D": tails[0].x += 1
				case "L": tails[0].y -= 1
				case "R": tails[0].y += 1
				default: fatalError("wrong input")
			}

			for i in 1...tails.count - 1 {
				if abs(tails[i-1].y - tails[i].y) > 1 ||
				   abs(tails[i-1].x - tails[i].x) > 1 {
					let movement = Point.init(
						x: tails[i-1].x - tails[i].x, 
						y: tails[i-1].y - tails[i].y
					)
					tails[i].x += movement.x != 0 ? movement.x / abs(movement.x) : 0
					tails[i].y += movement.y != 0 ? movement.y / abs(movement.y) : 0
					grids.insert(tails[i])
				}
			}
		}
	}
	return grids.count
}

func main() throws {
	let fileUrl = URL(fileURLWithPath: "./input.txt")
	let lines = try readFileLines(fileUrl: fileUrl)
	print("Part 1: ", solve(motions: lines))
	print("Part 2: ", solve2(motions: lines))
}

func test() {
	let test = [
		"R 4",
		"U 4",
		"L 3",
		"D 1",
		"R 4",
		"D 1",
		"L 5",
		"R 2",
	]
	let expected = 13
	
	let solved = solve(motions: test)
	print(solved)
	print(expected == solved)
}

func test2() {
	let test = [
		"R 5",
		"U 8",
		"L 8",
		"D 3",
		"R 17",
		"D 10",
		"L 25",
		"U 20",
	]
	let expected = 36
	
	let solved = solve2(motions: test)
	print(solved)
	print(expected == solved)
}

try main()
// test()
test2()
