import java.io.File
import java.io.InputStream

fun readLinesFromFile(path: String): List<String> {
    return File(path).inputStream().bufferedReader().readLines()
}

fun main() {
    val lines = readLinesFromFile("input.txt")
    for (line in lines) {
        println(line)
    }
}