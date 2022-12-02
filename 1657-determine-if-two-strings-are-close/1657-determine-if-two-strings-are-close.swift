class Solution {
    func closeStrings(_ word1: String, _ word2: String) -> Bool {
        var word1HashMap = [Character: Int]()
        var word2HashMap = [Character: Int]()
        
        for character in word1 { word1HashMap[character, default: 0] += 1 }
        for character in word2 { word2HashMap[character, default: 0] += 1 }
        
        return word1HashMap.keys == word2HashMap.keys && 
            word1HashMap.values.sorted() == word2HashMap.values.sorted()
    }
}