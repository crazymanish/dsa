class Solution {
    func canBeValid(_ s: String, _ locked: String) -> Bool {
        let n = s.count
        // If the length of s is odd, it cannot be a valid parentheses string
        if n % 2 != 0 { return false }
        
        let sArray = Array(s)
        let lockedArray = Array(locked)
        
        // Forward pass to check balance from left to right
        var balance = 0
        for i in 0..<n {
            if lockedArray[i] == "0" || sArray[i] == "(" {
                balance += 1
            } else {
                balance -= 1
            }
            
            // If balance is negative, we have more closing than opening parentheses
            if balance < 0 { return false }
        }
        
        // Backward pass to check balance from right to left
        balance = 0
        for i in (0..<n).reversed() {
            if lockedArray[i] == "0" || sArray[i] == ")" {
                balance += 1
            } else {
                balance -= 1
            }
            
            // If balance is negative, we have more opening than closing parentheses
            if balance < 0 { return false }
        }
        
        return true
    }
}