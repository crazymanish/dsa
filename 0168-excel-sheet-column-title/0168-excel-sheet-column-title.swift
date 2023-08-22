class Solution {
    func convertToTitle(_ columnNumber: Int) -> String {
        var columnNumber = columnNumber
        var columnTitle = ""
        
        while columnNumber > 0 {
            columnNumber -= 1
            
            let currentNumber = columnNumber % 26
            columnTitle.append(getChracter(currentNumber))
            
            columnNumber /= 26
        }
        
        return String(columnTitle.reversed())
    }

    private func getChracter(_ number: Int) -> Character {
        let startingValue = Int(UnicodeScalar(String("A"))!.value) // Capital A always starts with 65
        
        let ascii = UnicodeScalar(startingValue+number)!
        return Character(ascii)
    }
}