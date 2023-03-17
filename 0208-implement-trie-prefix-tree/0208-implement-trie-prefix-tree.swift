class Trie {
    var root = Trie.Node()
    
    init() {}

    func insert(_ word: String) {
        var current = root
        for char in word {
            current.childern[char] = current.childern[char, default: Trie.Node()]
            current = current.childern[char]!
        }
        current.isEnd = true
    }

    func search(_ word: String) -> Bool {
        var current = root
        for char in word {
            guard let child = current.childern[char] else { return false }
            current = child
        }
        return current.isEnd
    }

    func startsWith(_ prefix: String) -> Bool {
        var current = root
        for char in prefix {
            guard let child = current.childern[char] else { return false }
            current = child
        }
        return true
    }
}

extension Trie {
    class Node {
        var childern: [Character: Trie.Node] = [:]
        var isEnd = false
    }   
}

/**
 * Your Trie object will be instantiated and called as such:
 * let obj = Trie()
 * obj.insert(word)
 * let ret_2: Bool = obj.search(word)
 * let ret_3: Bool = obj.startsWith(prefix)
 */