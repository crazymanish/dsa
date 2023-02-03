class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        if s.count == 1 || numRows == 1 { return s }
        
        let s = Array(s)
        let charsInSection = 2 * (numRows - 1)
        var result = ""
        
        for currRow in 0..<numRows {
            var index = currRow
            
            while index < s.count {
                result += String(s[index])
                
                if currRow != 0 && currRow != numRows - 1 {
                    let charsInBetween = charsInSection - 2 * currRow
                    let secondIndex = index + charsInBetween
                    
                    if secondIndex < s.count {
                        result += String(s[secondIndex])
                    }
                }
                
                index += charsInSection
            }
        }
        
        return result
    }
}