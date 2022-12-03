import java.io.File
import java.io.InputStream

fun String.splitAtIndex(i: Int) = take(i) to substring(i)

fun toPrio(c: Char): Int {
    val addition = if (c.isUpperCase()) 27 else 1;
    return c.lowercaseChar().code - 'a'.code + addition;
}

fun splitInMiddle(s: String): Pair<String, String> {
    return s.splitAtIndex(s.length / 2);
}

fun readLinesFromFile(path: String): List<String> {
    return File(path).inputStream().bufferedReader().readLines()
} 

fun solve(strings: List<String>): Int {
    val priorities: MutableList<Int> = mutableListOf();
    val charSet: MutableSet<Char> = mutableSetOf();
    for(s in strings) {
        val (l, r) = splitInMiddle(s);
        for(c in l) {
            charSet.add(c);
        }
        for(c in r) {
            if(charSet.contains(c)) {
                priorities.add(toPrio(c));
                break;
            }
        }
        charSet.clear();
    }
    
    return priorities.sum();
}

fun main() {
    val lines = readLinesFromFile("input.txt")
    println("Part 1: ${solve(lines)}");
}