class WordDictionary {
    /// The root of the `Trie`
    private let root = Trie()
    
    /// Add a word to the dictionary by adding it to the `Trie`
    func addWord(_ word: String) {
        var prev = root
    
        for char in word {
            let node = prev.children[char] ?? Trie()
            prev.children[char] = node
            prev = node
        }
      
        prev.isFinal = true
    }
  
    /// Search for the word by performing a BFS of the `Trie`
    func search(_ word: String) -> Bool {
        var queue = [root]
    
        for char in word {
            guard char != "." else {
                queue = queue.flatMap { $0.children.values }
                continue
            }
            
            queue = queue.compactMap { $0.children[char] }
        }
    
        return queue.contains(where: { $0.isFinal })
    }
}

extension WordDictionary {
  /// `Trie` for efficient searches
  class Trie {
      var isFinal = false
      var children = [Character: Trie]()
  }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */