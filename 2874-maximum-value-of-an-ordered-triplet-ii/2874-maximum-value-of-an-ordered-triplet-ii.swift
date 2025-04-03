class Solution {
    func maximumTripletValue(_ nums: [Int]) -> Int {
        var maxTripletValue = 0 // Initialize the maximum triplet value found so far
        var maxPrefixDifference = 0 // Initialize the maximum (nums[i] - nums[j]) seen so far
        var maxFirstValue = 0 // Initialize the maximum nums[i] seen so far

        // Iterate through the array, using each element as a potential nums[k]
        for currentNumber in nums {
            // Calculate the potential triplet value using the current element as nums[k]
            maxTripletValue = max(maxTripletValue, maxPrefixDifference * currentNumber)

            // Update maxPrefixDifference considering the current element as a potential nums[j]
            // We want to find the maximum (nums[i] - nums[j]) for all i < j up to this point
            maxPrefixDifference = max(maxPrefixDifference, maxFirstValue - currentNumber)

            // Update maxFirstValue if the current element is larger, preparing for future calculations of (nums[i] - nums[j])
            maxFirstValue = max(maxFirstValue, currentNumber)
        }

        return maxTripletValue // Return the maximum triplet value found
    }
}