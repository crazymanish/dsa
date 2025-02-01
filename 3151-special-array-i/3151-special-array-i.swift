class Solution {
    func isArraySpecial(_ numbers: [Int]) -> Bool {
        // If the array has only one element, it is considered special
        if numbers.count == 1 { return true }
        
        // Iterate through the array and check adjacent elements
        for index in 0..<numbers.count - 1 {
            // Check if the current element and the next element have the same parity
            if (numbers[index] % 2 == numbers[index + 1] % 2) {
                return false
            }
        }
        
        // If all pairs have different parity, return true
        return true
    }
}