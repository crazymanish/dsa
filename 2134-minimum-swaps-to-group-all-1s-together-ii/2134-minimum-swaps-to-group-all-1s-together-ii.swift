class Solution {
    func minSwaps(_ nums: [Int]) -> Int {
        let totalOnes = nums.reduce(0, +)
        let doubleNums = nums + nums
        var currentOnes = doubleNums.prefix(totalOnes).reduce(0, +)
        var maxOnesInWindow = currentOnes
        
        for i in totalOnes..<doubleNums.count {
            currentOnes += doubleNums[i] - doubleNums[i - totalOnes]
            maxOnesInWindow = max(maxOnesInWindow, currentOnes)
        }
        
        return totalOnes - maxOnesInWindow
    }
}