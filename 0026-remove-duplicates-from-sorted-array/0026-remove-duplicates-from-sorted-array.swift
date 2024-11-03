class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var lastUniqueNumIndex = 0
        
        for index in 1..<nums.count {
            let lasUniqueValue = nums[lastUniqueNumIndex]
            let currentIndexValue = nums[index]
            
            guard currentIndexValue != lasUniqueValue else { continue }
            
            lastUniqueNumIndex += 1
            nums[lastUniqueNumIndex] = currentIndexValue
        }
        
        return lastUniqueNumIndex + 1 // +1 is needed for unique nums length
    }
}

/*
Example
Input: nums = [0, 0, 1, 1, 2, 2, 3, 4, 4]
Output: Length = 5, modified array (first 5 elements) = [0, 1, 2, 3, 4]

Approach: Two-Pointer Technique
Since the array is already sorted, duplicates will be adjacent. We can use a two-pointer technique:

- One pointer (left) keeps track of the position where the next unique element should go.
- The other pointer (right) traverses the entire array to find the next unique element.

Steps for Execution
- Initialize left to 0. This pointer will track the end of the list of unique elements.
- Start a loop with right pointer at index 1 (since the first element at nums[0] is always unique).

- For each element at nums[right]:
 - If nums[right] is different from nums[left]:
 - Increment left by 1 (to the next position for a unique element).
 - Copy nums[right] to nums[left].
 - Continue this until right reaches the end of the array.
 - The number of unique elements will be left + 1.

Step-by-Step Execution
- Let’s walk through an example with nums = [0, 0, 1, 1, 2, 2, 3, 4, 4].

Initial Array and Pointer Setup
- Initial array: [0, 0, 1, 1, 2, 2, 3, 4, 4]
- left = 0, right = 1

Iteration 1: right = 1
nums[right] is 0, which is the same as nums[left] (0).
No changes are made, move right to the next position.

Iteration 2: right = 2
nums[right] is 1, which is different from nums[left] (0).
Increment left to 1.
Set nums[left] = nums[right], updating the array to [0, 1, 1, 1, 2, 2, 3, 4, 4].
Move right to the next position.

Iteration 3: right = 3
nums[right] is 1, which is the same as nums[left] (1).
No changes are made, move right to the next position.

Iteration 4: right = 4
nums[right] is 2, which is different from nums[left] (1).
Increment left to 2.
Set nums[left] = nums[right], updating the array to [0, 1, 2, 1, 2, 2, 3, 4, 4].
Move right to the next position.

Iteration 5: right = 5
nums[right] is 2, which is the same as nums[left] (2).
No changes are made, move right to the next position.

Iteration 6: right = 6
nums[right] is 3, which is different from nums[left] (2).
Increment left to 3.
Set nums[left] = nums[right], updating the array to [0, 1, 2, 3, 2, 2, 3, 4, 4].
Move right to the next position.

Iteration 7: right = 7
nums[right] is 4, which is different from nums[left] (3).
Increment left to 4.
Set nums[left] = nums[right], updating the array to [0, 1, 2, 3, 4, 2, 3, 4, 4].
Move right to the next position.

Iteration 8: right = 8
nums[right] is 4, which is the same as nums[left] (4).
No changes are made, and right reaches the end of the array.

Final Array
The modified array is: [0, 1, 2, 3, 4, _, _, _, _] (only the first 5 elements are relevant). The length of the unique elements array is left + 1 = 5.

Complexity Analysis
Time Complexity: O(n), as we’re iterating through the array once.
Space Complexity:O(1), as we’re modifying the array in-place.
*/