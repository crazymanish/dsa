class TrieNode { 
    var next: [Substring: TrieNode] = [:]
    var isEnd = false 
}

class Solution {
    func removeSubfolders(_ folders: [String], _ root: TrieNode = TrieNode()) -> [String] {
        folders.sorted().filter { path in
            var node = root
            
            for item in path.split(separator: "/") {
                guard node.next[item]?.isEnd != true else { return false }
                
                node.next[item] = node.next[item] ?? TrieNode()
                node = node.next[item]!
            }
                                 
            node.isEnd = true
            return true // only accept if we're able to set `isEnd` to true.
        }
    }
}