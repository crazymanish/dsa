class Solution {
    func canBeValid(_ s: String, _ locked: String) -> Bool {
        guard s.count % 2 == 0 else { return false }
        
        let sArray = Array(s)
        let lockedArray = Array(locked)
        
        //forward
        var balance = 0
        for index in 0..<sArray.count {
            if sArray[index] == ")" && lockedArray[index] == "1" {
                balance -= 1
            } else {
                balance += 1
            }
            
            if balance < 0 { return false }
        }
        
        //backward
        balance = 0
        for index in (0..<sArray.count).reversed() {
            if sArray[index] == "(" && lockedArray[index] == "1" {
                balance -= 1
            } else {
                balance += 1
            }
            
            if balance < 0 { return false }
        }
        
        return true
    }
}