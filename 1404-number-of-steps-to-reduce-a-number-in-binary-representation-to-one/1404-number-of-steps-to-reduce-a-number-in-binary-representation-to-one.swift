class Solution {
    func numSteps(_ s: String) -> Int {
        let sArray = Array(s)
        var operation = 0
        var carry = 0
        
        for i in stride(from: sArray.count - 1, to: 0, by: -1) {
            let digit = Int(String(sArray[i]))! + carry
            
            if digit % 2 == 1 {
                operation += 2
                carry = 1
            }else {
                operation += 1
            }
        }
        
        return operation + carry
    }
}