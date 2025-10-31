// Time Complexity: O(N)
// Let N be the number of elements in the `nums` array.
// 1. The first loop (`for num in nums`) iterates N times to build the
//    `frequencyMap`. Dictionary insertion/update is O(1) on average.
//    Total time for this pass is O(N).
// 2. The second loop (`for (number, count) in frequencyMap`) iterates
//    through the map. In the worst case, the map has N unique entries
//    (if all nums are unique). Total time for this pass is O(N).
// The total time is O(N) + O(N) = O(N).

// Space Complexity: O(N)
// 1. `frequencyMap`: In the worst case, if all N numbers are unique,
//    the dictionary will store N key-value pairs, requiring O(N) space.
// 2. `duplicates`: In the worst case, this array could store up to
//    N/2 elements (e.g., [1,1,2,2,...]), requiring O(N) space.
// The total space is proportional to N.

class Solution {
    /// - Parameter nums: An array of integers.
    /// - Returns: An array containing all numbers that appeared in `nums`
    ///            more than once. The order of numbers in the
    ///            returned array is not guaranteed.
    func getSneakyNumbers(_ nums: [Int]) -> [Int] {
        // 1. Build a frequency map to count occurrences of each number.
        //    [Number: Count]
        var frequencyMap = [Int: Int]()
        
        // Iterate through each number in the input array.
        // This is more idiomatic than using `for i in 0..<nums.count`.
        for num in nums {
            // Increment the count for `num`. If `num` isn't in the map,
            // `default: 0` provides a 0 to increment from.
            frequencyMap[num, default: 0] += 1
        }
        
        // 2. Collect all numbers that have a frequency greater than 1.
        var duplicates = [Int]()
        
        // Iterate through the key-value pairs in the completed map.
        for (number, count) in frequencyMap {
            // If the count is 2 or more, it's a duplicate.
            if count > 1 {
                duplicates.append(number)
            }
        }
        
        // Return the array of numbers that appeared more than once.
        return duplicates
    }
}