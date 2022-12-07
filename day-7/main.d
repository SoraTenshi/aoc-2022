import std;

class File {
   public string name;
   public uint size;

   public this(string name, uint size) {
        this.name = name;
        this.size = size;
    }
}

class Directory {
    public Directory parent;
    public Directory[] subs;
    public File[] files;

    public string name = "/";
    public uint size;

    public this(Directory parent, Directory[] subs, File[] files, string name, uint size) {
        this.parent = parent;
        this.subs = subs;
        this.files = files;
        this.name = name;
        this.size = size;
    }
}

void printFromRoot(Directory root, int level = 0)
{
    foreach(_; 0..level) write("--");
    write("> ");
    
    writeln(root.name, " size = ", root.size);
    foreach(file; root.files) {
        foreach(_; 0..level) write("  ");
        writeln(">> ", file.name, " size = ", file.size);
    }

    foreach (sub; root.subs) printFromRoot(sub, level + 1);
}

auto readLinesFromFile(string path) {
    auto text = readText(path);
    return text.splitLines();
}

auto handleCd(Directory dir, string name) {
    if(name == "..") {
        return dir.parent;
    }

    foreach(subDir; dir.subs) {
        if(subDir.name == name) {
            return subDir;
        }
    }

    return dir;
}

auto parse(string[] lines) {
    Directory fileSystem = new Directory(null, [], [], "/", 0);
    foreach(line; lines) {
        auto split = line.strip.split(" ");
        if(split[0] == "$") {
            if(split[1] == "cd") {
                fileSystem = handleCd(fileSystem, split[2]);
            }
        } else if(split[0] == "dir") {
            auto newDir = new Directory(fileSystem, [], [], split[1], 0);
            if(!fileSystem.subs.canFind!(sub => (canFind(sub.name, newDir.name)))) {
                fileSystem.subs ~= newDir;
            }
        } else {
            auto newFile = new File(split[1], to!uint(split[0]));
            if(!canFind(fileSystem.files, newFile)) { 
                fileSystem.files ~= newFile;
                fileSystem.size += to!uint(split[0]);
            }
        }
    }

    do {
        fileSystem = fileSystem.parent;
    } while(fileSystem.name != "/");

    return fileSystem;
}

uint traverseSubDirSize(Directory root) {
    uint sum = 0;
    foreach(dirs; root.subs) {
        dirs.parent.size = dirs.size + traverseSubDirSize(dirs);
        sum += dirs.parent.size;
    }
    return sum;
}

uint checkFor100k(Directory root) {
    uint sum = 0;
    foreach(dirs; root.subs) {
        if(dirs.size <= 100_000) {
            sum += dirs.size;
        }
        sum += checkFor100k(dirs);
    }
    
    return sum;
}

uint[] getMinSize(Directory root, uint toSearch) {
    uint[] candidates = [];
    foreach(sub; root.subs) {
        if(sub.size >= toSearch) {
            candidates ~= sub.size;
        }
        candidates ~= getMinSize(sub, toSearch);
    }
    return candidates;
}

auto solve(string[] lines) {
    auto root = parse(lines);
    root.size = root.size + traverseSubDirSize(root);

    return checkFor100k(root);
}

auto solve2(string[] lines) {
    auto root = parse(lines);
    root.size = root.size + traverseSubDirSize(root);
    printFromRoot(root);

    uint maxSpace = 70_000_000;
    uint minFreeSpace = 30_000_000;

    uint unusedSpace = maxSpace - root.size;
    uint toClear = minFreeSpace - unusedSpace;
    auto sorted = getMinSize(root, toClear).sort!("a < b");
    return sorted[0];
}

auto main() {
    auto lines = readLinesFromFile("./input.txt");
    writeln("Part 1: ", solve(lines));
    writeln("Part 2: ", solve2(lines));
}