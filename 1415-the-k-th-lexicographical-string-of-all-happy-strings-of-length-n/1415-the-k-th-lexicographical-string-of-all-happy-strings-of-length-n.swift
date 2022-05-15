class Solution {
    func getHappyString(_ n: Int, _ k: Int) -> String {
        var allHappyStringCount = 0
        var lastHappyString = ""
        var currentHappyString = ""
        var characters: [Character] = ["a", "b", "c"]
        
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