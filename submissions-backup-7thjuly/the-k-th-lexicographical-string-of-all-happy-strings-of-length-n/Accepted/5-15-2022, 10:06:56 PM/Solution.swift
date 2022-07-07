// https://leetcode.com/problems/the-k-th-lexicographical-string-of-all-happy-strings-of-length-n

class Solution {
    func getHappyString(_ n: Int, _ k: Int) -> String {
        let characters: [Character] = ["a", "b", "c"]
        
        var allHappyStringCount = 0
        var lastHappyString = ""
        var currentHappyString = ""
        
        var isKthHappyStringFound: Bool { allHappyStringCount == k }
        
        func findHappyString() {
            // we already found kth happy string, STOP now. No more looking
            if isKthHappyStringFound { return }
            
            // Found a happy-string with size n
            if currentHappyString.count == n { 
                allHappyStringCount += 1 
                lastHappyString = currentHappyString
                return
            }
            
            for character in characters {
                let lastCharacter = currentHappyString.last
                
                if currentHappyString.isEmpty || lastCharacter! != character {
                    currentHappyString += String(character)
                    findHappyString()
                    currentHappyString.removeLast() // backtracking
                }
            }
        }
        
        findHappyString()
        return isKthHappyStringFound ? lastHappyString : ""
    }
}