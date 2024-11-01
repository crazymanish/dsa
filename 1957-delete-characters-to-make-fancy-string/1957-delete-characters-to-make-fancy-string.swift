class Solution {
    func makeFancyString(_ s: String) -> String {
        var result = ""
        var streak = 1
        
        for char in s {
            streak = char == result.last ? streak+1 : 1
            
            guard streak < 3 else { continue }
            
            result.append(char)
        }
        
        return result
    }
}