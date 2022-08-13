class Solution {
    class TrieNode {
        var word: String?
        var children = [Character: TrieNode]()
    }

    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        guard words.count > 0 && words[0].count > 0 else { return [] }
        let count = words.count, len = words[0].count
        
        // build trie
        let trieRoot = TrieNode()
        for word in words {
            var node = trieRoot
            for char in word {
                if node.children[char] == nil {
                    node.children[char] = TrieNode()
                }
                node = node.children[char]!
            }
            node.word = word
        }
        
        // build counter
        var counter = [String: Int]()
        for word in words {
            counter[word, default: 0] += 1
        }
        
        // search
        var result = [Int]()
        let s = Array(s)
        iLoop: for i in 0..<s.count where i + len * count <= s.count {
            var j = i
            var counter = counter
            while j < i + len * count {
                var node = trieRoot, k = j
                while k < j + len {
                    guard let next = node.children[s[k]] else { continue iLoop }
                    node = next
                    k += 1
                }
                
                let word = node.word!
                guard counter[word, default: 0] > 0 else { continue iLoop }
                counter[word, default: 0] -= 1
                
                j = k
            }
            result.append(i)
        }
        
        return result
    }
}