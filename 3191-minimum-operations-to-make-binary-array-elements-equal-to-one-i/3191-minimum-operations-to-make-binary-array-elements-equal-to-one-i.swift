class Solution {
    func minOperations(_ nums: [Int]) -> Int {
        let arrayLength = nums.count // Length of the input array
        var operationCount = 0 // Count of operations performed
        var mutableArray = nums // Mutable copy of the input array

        // Iterate through the array
        for currentIndex in 0..<arrayLength {
            // Check if the current element is 0
            if mutableArray[currentIndex] == 0 {
                // Check if there are enough elements ahead to perform the flip operation
                if currentIndex + 2 < arrayLength {
                    operationCount += 1 // Increment the operation count
                    mutableArray[currentIndex] ^= 1 // Flip the current element
                    mutableArray[currentIndex + 1] ^= 1 // Flip the next element
                    mutableArray[currentIndex + 2] ^= 1 // Flip the element after the next
                } else {
                    return -1 // Return -1 if it's impossible to make all elements 1
                }
            }
        }
        return operationCount // Return the minimum number of operations performed
    }
}