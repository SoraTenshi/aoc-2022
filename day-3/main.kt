import java.io.File

fun String.splitAtIndex(i: Int) = take(i) to substring(i)

fun toPrio(c: Char): Int {
    val addition = if (c.isUpperCase()) 27 else 1
    return c.lowercaseChar().code - 'a'.code + addition
}

fun splitInMiddle(s: String): Pair<String, String> {
    return s.splitAtIndex(s.length / 2)
}

fun readLinesFromFile(path: String): List<String> {
    return File(path).inputStream().bufferedReader().readLines()
}

fun solve(strings: List<String>): Int {
    var prio = 0
    val charSet: MutableSet<Char> = mutableSetOf()
    for (s in strings) {
        val (l, r) = splitInMiddle(s)
        for (c in l) {
            charSet.add(c)
        }
        for (c in r) {
            if (charSet.contains(c)) {
                prio += toPrio(c)
                break
            }
        }
        charSet.clear()
    }

    return prio
}

fun solve2(lines: List<String>): Int {
    var prio = 0
    val itemMap = mutableMapOf<Char, Int>()
    
    for(elfGroup in lines.chunked(3)) {
        val first = elfGroup[0]
        val second = elfGroup[1]
        val third = elfGroup[2]

        for(c in first) {
            itemMap.put(c, 0)
        }
        
        for(c in second) {
            if(itemMap.containsKey(c)) {
                itemMap[c] = 1
            }
        }
        
        for(c in third) {
            if(itemMap.containsKey(c) && itemMap[c] == 1) {
                prio += toPrio(c)
                break
            }
        }

        itemMap.clear()
    }
    
    return prio
}

fun main() {
    val lines = readLinesFromFile("input.txt")
    println("Part 1: ${solve(lines)}")
    println("Part 2: ${solve2(lines)}")
}
