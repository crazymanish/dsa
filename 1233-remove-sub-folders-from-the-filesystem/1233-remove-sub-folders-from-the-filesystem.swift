/*
Complexity Analysis
Let N be the number of folders, M be the maximum length of a folder path, and L be the total number of characters across all paths.

Time Complexity: O(N * M * log N)
The performance is dominated by the initial sorting of the folder paths. Sorting N strings, where each comparison can take up to M operations, results in this complexity. The subsequent Trie operations are faster than the sort.

Space Complexity: O(L)
The space required is determined by the size of the Trie. In the worst-case scenario, the Trie needs to store all unique path components, which is proportional to L, the total number of characters in all paths.
*/
class TrieNode {
    // A dictionary mapping a folder name to the next node in the path.
    var children: [Substring: TrieNode] = [:]
    // A flag to mark the end of a complete, valid folder path.
    var isEnd = false
}

class Solution {
    /// Removes all subfolders from a list of folder paths.
    /// A folder "/a/b" is a subfolder of "/a".
    func removeSubfolders(_ folders: [String]) -> [String] {
        let root = TrieNode()

        // Sort the folders lexicographically. This ensures that parent folders
        // (e.g., "/a") are processed before their children (e.g., "/a/b").
        return folders.sorted().filter { path in
            var currentNode = root

            // Traverse the Trie for each component of the path.
            for component in path.split(separator: "/") {
                // If a prefix of the current path already exists as a complete folder,
                // then this path is a subfolder and should be removed.
                if let childNode = currentNode.children[component], childNode.isEnd {
                    return false // Found a parent folder, so filter this path out.
                }

                // If the component doesn't exist, create a new node.
                if currentNode.children[component] == nil {
                    currentNode.children[component] = TrieNode()
                }

                // Move to the next node in the Trie.
                currentNode = currentNode.children[component]!
            }

            // If we successfully traversed the whole path without finding a parent,
            // mark it as a valid folder path and keep it.
            currentNode.isEnd = true
            return true
        }
    }
}