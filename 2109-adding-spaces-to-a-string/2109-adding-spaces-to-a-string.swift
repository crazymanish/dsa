class Solution {
    func addSpaces(_ s: String, _ spaces: [Int]) -> String {
        var result = ""
        var spaceIndex = 0
        let spaceCount = spaces.count
        let characters = Array(s)
    
        for i in 0..<characters.count {
            if spaceIndex < spaceCount && i == spaces[spaceIndex] {
                result.append(" ")
                spaceIndex += 1
            }
            result.append(characters[i])
        }
    
        return result
    }
}