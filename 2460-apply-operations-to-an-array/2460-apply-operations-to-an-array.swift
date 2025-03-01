class Solution {
    func applyOperations(_ nums: [Int]) -> [Int] {
        var modifiedNums = nums // Make a mutable copy of the input array

        // Apply operations
        for i in 0..<modifiedNums.count - 1 {
            if modifiedNums[i] == modifiedNums[i + 1] {
                modifiedNums[i] *= 2 // Multiply the current element by 2
                modifiedNums[i + 1] = 0 // Set the next element to 0
            }
        }

        // Shift zeros to the end
        var nextNonZeroIndex = 0
        for i in 0..<modifiedNums.count {
            if modifiedNums[i] != 0 {
                modifiedNums.swapAt(i, nextNonZeroIndex) // Swap non-zero elements to the front
                nextNonZeroIndex += 1
            }
        }

        return modifiedNums
    }
}