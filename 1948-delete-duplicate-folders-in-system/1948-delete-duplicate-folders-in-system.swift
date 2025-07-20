/*
Complexity Analysis
Let L be the total number of characters across all paths (e.g., for [["a", "b"], ["a", "c"]], L = 4). Let D be the maximum depth of any path.

Time Complexity: O(L)
- Tree Building: Constructing the tree requires processing each component of each path. With the dictionary optimization, this takes time proportional to the total number of characters, O(L).
- Hashing & Traversals: The three subsequent traversals (hashing, removing duplicates, and enumerating the final paths) each visit every node in the tree exactly once. The number of nodes is bounded by L. Therefore, these steps are also O(L).
- The overall complexity is dominated by these linear-time operations.

Space Complexity: O(L)
- Tree Storage: The space required to store the folder tree is proportional to the total number of nodes and folder names, which is O(L).
- Hash Storage: The hashesFrequency dictionary stores a hash for each node in the tree, also contributing O(L) to the space complexity.
*/
class Solution {
    func deleteDuplicateFolder(_ paths: [[String]]) -> [[String]] {
        // --- 1. Build the Tree ---
        // Create a root and insert all paths into it.
        let root = Folder(name: "/")
        for path in paths {
            root.insert(path: path)
        }

        // --- 2. Calculate Hashes ---
        // Calculate a hash for each folder's structure and count frequencies.
        var hashesFrequency: [Int: Int] = [:]
        root.updateHashes(hashesFrequency: &hashesFrequency)

        // --- 3. Identify and Prune Duplicates ---
        // A structure is duplicated if its hash appears more than once.
        // We ignore the hash for an empty structure (0), as we don't want to delete all empty folders.
        let duplicatedHashes = Set(hashesFrequency.filter { $0.value > 1 && $0.key != 0 }.keys)
        root.removeDuplicates(duplicatedStructureHashes: duplicatedHashes)

        // --- 4. Reconstruct Final Paths ---
        // Traverse the pruned tree to get the final list of paths.
        var finalPaths: [[String]] = []
        // Sort by name for deterministic output.
        for folderName in root.subfolders.keys.sorted() {
             root.subfolders[folderName]?.enumerateAllFolders(into: &finalPaths, currentPath: [])
        }
        
        return finalPaths
    }
}

/// Represents a single folder in the file system tree.
private final class Folder {
    var name: String
    // Using a dictionary for subfolders allows for O(1) average time complexity for insertions and lookups.
    var subfolders: [String: Folder] = [:]
    // Stores the hash representing the structure of this folder's subdirectories.
    var structureHash: Int = 0

    init(name: String) { self.name = name }

    /// Recursively inserts a path into the tree structure.
    func insert(path: [String]) {
        guard let folderName = path.first else { return }
        
        let remainingPath = Array(path.dropFirst())
        
        // Find or create the next folder in the path.
        let nextFolder = subfolders[folderName, default: Folder(name: folderName)]
        nextFolder.insert(path: remainingPath)
        
        // Add the new or existing folder to the dictionary.
        subfolders[folderName] = nextFolder
    }

    /// Traverses the tree bottom-up (post-order) to calculate a hash for each folder's structure.
    /// Returns the final hash for the current node, which includes its name and its structure hash.
    @discardableResult
    func updateHashes(hashesFrequency: inout [Int: Int]) -> Int {
        // An empty folder has a structure hash of 0.
        guard !subfolders.isEmpty else { return name.hashValue }

        // 1. Recursively get hashes for all subfolders.
        // 2. Sort hashes to make the structure hash order-independent.
        //    (e.g., hash of [a, b] should be the same as [b, a])
        let childStructureHashes = subfolders.values
            .map { $0.updateHashes(hashesFrequency: &hashesFrequency) }
            .sorted()

        // 3. Combine the sorted hashes into a single string to represent the subfolder structure.
        let combinedHashString = childStructureHashes.map(String.init).joined(separator: ",")
        self.structureHash = combinedHashString.hashValue
        
        // 4. Record the frequency of this specific structure.
        hashesFrequency[self.structureHash, default: 0] += 1
        
        // 5. The final hash for this node includes its own name, making it unique.
        //    (e.g., "/a" with structure "X" is different from "/b" with structure "X")
        return "\(self.structureHash),\(self.name)".hashValue
    }

    /// Traverses the tree top-down (pre-order) to remove folders whose structure is a duplicate.
    func removeDuplicates(duplicatedStructureHashes: Set<Int>) {
        // Filter out subfolders that have a duplicated structure.
        subfolders = subfolders.filter { _, folder in
            !duplicatedStructureHashes.contains(folder.structureHash)
        }
        // Continue the process recursively for the remaining children.
        for folder in subfolders.values {
            folder.removeDuplicates(duplicatedStructureHashes: duplicatedStructureHashes)
        }
    }

    /// Traverses the final, pruned tree to build the list of valid folder paths.
    func enumerateAllFolders(into allFolders: inout [[String]], currentPath: [String]) {
        let newPath = currentPath + [self.name]
        allFolders.append(newPath)
        
        // Sort by name to ensure deterministic output.
        for folderName in subfolders.keys.sorted() {
            subfolders[folderName]?.enumerateAllFolders(into: &allFolders, currentPath: newPath)
        }
    }
}