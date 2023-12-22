class Solution {
    func maxScore(_ s: String) -> Int {
        // initially, left substring is empty, right is all string
        var score = s.filter{ $0 == "1" }.count // ones on the right side
        var maxScore = Int.min
        
        for char in s[..<s.index(before: s.endIndex)] {
            if char == "0" { // zeros on the left side += 1
                score += 1 
            } else { // ones on the right side -= 1
                score -= 1 
            }  
            
            maxScore = max(maxScore, score)
        }
        
        return maxScore
    }
}