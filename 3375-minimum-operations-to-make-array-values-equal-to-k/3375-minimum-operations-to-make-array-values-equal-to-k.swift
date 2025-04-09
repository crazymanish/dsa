class Solution {
    func minOperations(_ nums: [Int], _ k: Int) -> Int {
        let uniqueNumbers = Set(nums) // Create a set to find the number of distinct elements
        let minimumValue = nums.min()! // Find the minimum value in the array

        // If k is greater than the minimum value, it's impossible to make all elements equal to k
        if k > minimumValue { return -1 }

        // If k is equal to the minimum value, the answer is the number of distinct elements - 1
        // because we can reduce all other distinct elements to k in one operation each.
        if k == minimumValue {
            return uniqueNumbers.count - 1
        } else {
            // Otherwise, the answer is the number of distinct elements
            // because we need one operation to reduce each distinct element to a valid 'h' and another to make them equal to k.
            return uniqueNumbers.count
        }
    }
}