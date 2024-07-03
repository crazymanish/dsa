class Solution {
    func minDifference(_ nums: [Int]) -> Int {
        // If there are less than 5 elements, the minimum difference is 0
        guard nums.count > 4 else { return 0 }
        
        // Sort the array to allow for easy comparison of elements
        let sortedNums = nums.sorted()
        
        // Initialize the minimum difference to a large value
        var minimumDifference = Int.max
        
        // Compare the smallest 4 elements with the largest 4 elements
        // This captures the scenarios where we change up to 3 elements
        for i in 0..<4 {
            let difference = sortedNums[sortedNums.count - 4 + i] - sortedNums[i]
            minimumDifference = min(minimumDifference, difference)
        }
        
        return minimumDifference
    }
}