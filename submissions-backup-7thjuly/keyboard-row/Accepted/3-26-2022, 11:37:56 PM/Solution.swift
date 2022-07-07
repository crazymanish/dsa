// https://leetcode.com/problems/keyboard-row

class Solution {
    func findWords(_ words: [String]) -> [String] {
        var hashMap: [Character : Int] = ["q":1,"w":1,"e":1,"r":1,"t":1,"y":1,"u":1,"i":1,"o":1,"p":1,"a":2,"s":2,"d":2,"f":2,"g":2,"h":2,"j":2,"k":2,"l":2,"z":3,"x":3,"c":3,"v":3,"b":3,"n":3,"m":3]
        
        var outputWords: [String] = []
        
        for word in words {
            var canTypeUsingOneRow = true
            var initialCharRow: Int? = nil
            for char in word.lowercased() {
                if let expectedRow = initialCharRow {
                    if expectedRow != hashMap[char]! {
                        canTypeUsingOneRow = false
                        break
                    }
                } else {
                    initialCharRow = hashMap[char]
                }
            }
            
            if canTypeUsingOneRow { outputWords.append(word) }
        }
        
        return outputWords
    }
}