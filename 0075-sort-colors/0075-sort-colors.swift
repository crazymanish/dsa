class Solution {
    /**
     Sorts an array containing only 0s, 1s, and 2s in-place.

     This function uses a counting sort approach. It first counts the occurrences
     of each number (0, 1, and 2) in the input array. Then, it overwrites the
     original array with the sorted numbers based on these counts.

     - Parameter nums: An in-out array of integers, where each integer is 0, 1, or 2.
                       The array will be modified in-place to be sorted.

     - Time Complexity: O(N), where N is the number of elements in the `nums` array.
       - The first loop iterates through the `nums` array once to count the occurrences of each number, which takes O(N) time.
       - The second loop iterates a constant number of times (0, 1, 2).
       - The inner while loop, in total across all iterations of the outer loop, runs N times because it places each of the N elements back into the array.
       - Therefore, the dominant part is O(N).

     - Space Complexity: O(1).
       - The `hashMap` stores counts for a fixed number of keys (0, 1, 2), so its size is constant (3 key-value pairs).
       - Thus, the auxiliary space used does not depend on the size of the input array `nums`.
     */
    func sortColors(_ nums: inout [Int]) {
        // Initialize a hash map (or dictionary) to store the frequency of each number (0, 1, 2).
        // Keys are the numbers (0, 1, 2) and values are their counts.
        var hashMap = [0: 0, 1: 0, 2: 0]
        
        // First pass: Count the occurrences of each number in the input array.
        // Iterate through each element in the `nums` array.
        for num in nums {
            // Increment the count for the current number in the hashMap.
            // The `!` is used for force unwrapping, assuming `num` will always be 0, 1, or 2.
            hashMap[num] = hashMap[num]! + 1
        }
        
        // Initialize an index to keep track of the current position to overwrite in the `nums` array.
        var index = 0
        
        // Second pass: Overwrite the `nums` array with the sorted numbers.
        // Iterate through the numbers 0, 1, and 2 in order.
        for num in 0...2 { // This loop runs for num = 0, then num = 1, then num = 2.
            // Get the count of the current number (0, 1, or 2) from the hashMap.
            // The `!` is used for force unwrapping, as we know 0, 1, and 2 are keys in hashMap.
            var count = hashMap[num]!
            
            // While there are still occurrences of the current number to place in the array:
            while count > 0 {
                // Place the current number (`num`) at the current `index` in the `nums` array.
                nums[index] = num
                
                // Move to the next position in the `nums` array.
                index += 1
                // Decrement the count of the current number.
                count -= 1
            }
        }
    }
}