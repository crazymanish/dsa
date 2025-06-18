// Time Complexity: O(n log n)
// The time complexity is dominated by the sorting of the input array, which takes O(n log n) time.
// The subsequent loop to create subarrays runs in O(n) time.
//
// Space Complexity: O(n)
// The space complexity is O(n) to store the sorted array and the result array. In the worst case,
// the result array will contain all n elements from the input array.
class Solution {
    /// Divides an array into subarrays of size 3, with a condition on the maximum difference between elements.
    ///
    /// - Parameters:
    ///   - numbers: An array of integers to be divided.
    ///   - maxDifference: The maximum allowed difference between the largest and smallest elements in any subarray.
    /// - Returns: An array of subarrays, each of size 3, that satisfy the difference condition. Returns an empty array if it's not possible.
    func divideArray(_ numbers: [Int], _ maxDifference: Int) -> [[Int]] {
        // Sort the array to easily find the minimum and maximum elements in any potential subarray of size 3.
        // After sorting, for any three consecutive elements, the first will be the smallest and the third will be the largest.
        let sortedNumbers = numbers.sorted()
        
        // This will store the resulting subarrays.
        var dividedArrays = [[Int]]()
        
        // Iterate through the sorted array in steps of 3 to consider elements for each subarray.
        for i in stride(from: 0, to: sortedNumbers.count, by: 3) {
            // Check if the difference between the largest (at index i+2) and smallest (at index i)
            // elements in the potential subarray is greater than the allowed maximum difference.
            if sortedNumbers[i+2] - sortedNumbers[i] > maxDifference {
                // If the condition is not met for any group, it's impossible to create the desired subarrays.
                return []
            }
            
            // If the condition is met, create a new subarray with the three consecutive elements.
            let currentSubarray = [sortedNumbers[i], sortedNumbers[i+1], sortedNumbers[i+2]]
            
            // Add the newly created subarray to our result.
            dividedArrays.append(currentSubarray)
        }
        
        // Return the final list of subarrays.
        return dividedArrays
    }
}