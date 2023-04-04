class Solution {
    func partitionString(_ s: String) -> Int {
        var partitionCount = 1
        var visitedCharacters = Set<Character>()

        for character in Array(s) {
            if visitedCharacters.contains(character) {
                partitionCount += 1
                visitedCharacters.removeAll()
            }
            
            visitedCharacters.insert(character)
        }
        
        return partitionCount        
    }
}