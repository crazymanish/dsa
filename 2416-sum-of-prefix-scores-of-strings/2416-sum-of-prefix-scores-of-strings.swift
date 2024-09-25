class Solution {
    func sumPrefixScores(_ words: [String]) -> [Int] {
        class TrieNode {
            var next = [Character:TrieNode]()
            var prefixCount = 0 // every char that is added increments this
        }
		
		// construct trie
        let trie = words.reduce(into: TrieNode()) { trie, word in
            word.reduce(into: trie) { node, ch in
                node.next[ch] = node.next[ch] ?? TrieNode()
                node = node.next[ch]!
                node.prefixCount += 1
            }
        }
        
		// for each word, sum up prefix counts for each character
        return words.map { word in
            var node = trie
            return word.reduce(into: 0) { result, ch in
                node = node.next[ch]!
                result += node.prefixCount
            }
        }
    }
}