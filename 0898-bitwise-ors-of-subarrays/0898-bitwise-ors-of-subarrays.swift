// Time Complexity: O(N * K)
// where N is the number of elements and K is the number of bits in an integer (e.g., 32).
// The algorithm iterates through the array once (O(N)). In each step, it processes a set of
// previous OR values, the size of which is bounded by K.
//
// Space Complexity: O(N * K)
// The main result set (`allPossibleORs`) could store a large number of unique values in
// the worst case. The intermediate set (`orValuesEndingAtPrev`) requires O(K) space.
class Solution {
    /// Calculates the number of unique values that can be obtained by taking the
    /// bitwise OR of all elements in any contiguous subarray of the input array.
    func subarrayBitwiseORs(_ nums: [Int]) -> Int {
        // `allPossibleORs` stores the final set of all unique OR values found.
        var allPossibleORs = Set<Int>()
        
        // `orValuesEndingAtPrev` stores the set of OR values for all subarrays ending at the previous element (i-1).
        // This is our DP state.
        var orValuesEndingAtPrev = Set<Int>()

        for currentNum in nums {
            // `orValuesEndingAtCurrent` will store the set of OR values for all subarrays ending at the current element.
            var orValuesEndingAtCurrent = Set<Int>()
            
            // The first new OR value is just the current number itself (for the subarray of length 1).
            orValuesEndingAtCurrent.insert(currentNum)
            
            // To get the rest of the ORs ending at the current position, we extend the previous subarrays.
            // The DP relationship is: OR(nums[j..i]) = OR(nums[j..i-1]) | nums[i].
            for prevOR in orValuesEndingAtPrev {
                orValuesEndingAtCurrent.insert(currentNum | prevOR)
            }
            
            // Add all newly found OR values to our global result set.
            allPossibleORs.formUnion(orValuesEndingAtCurrent)
            
            // The current set of ORs becomes the previous set for the next iteration.
            orValuesEndingAtPrev = orValuesEndingAtCurrent
        }
        
        return allPossibleORs.count
    }
}