// https://leetcode.com/problems/implement-magic-dictionary

class MagicDictionary {
    var set: Set<String>
    
    init() {
        set = []
    }
    
    func buildDict(_ dictionary: [String]) {
        for word in dictionary { set.insert(word) }
    }
    
    func search(_ searchWord: String) -> Bool {
        if set.isEmpty { return false }
        
        for word in set {
            if word.count == searchWord.count {
                var diff = 0
                for index in 0..<word.count {
                    let wordChar = word[index]
                    let searchWordChar = searchWord[index]
                    
                    if wordChar != searchWordChar { diff += 1 }
                }
                
                if diff == 1 { return true }
            }
        }
        
        return false
    }
}

private extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}

/**
 * Your MagicDictionary object will be instantiated and called as such:
 * let obj = MagicDictionary()
 * obj.buildDict(dictionary)
 * let ret_2: Bool = obj.search(searchWord)
 */