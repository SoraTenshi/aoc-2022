import java.io.File
import java.io.InputStream

fun read_lines_from_file(path: String): Array<String> {
    val inputStr = File(path).inputStream();
    val lineList = mutableListOf<String>();
    
    inputStr.bufferedReader().useLines { lines -> lines.forEach { lineList.add(it) } }
    return lineList.toTypedArray();
}

fun main() {
    val lines = read_lines_from_file("input.txt");
    for(line in lines) {
        println("${line}");
    }
}
