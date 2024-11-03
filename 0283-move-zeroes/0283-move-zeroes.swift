class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 1 else { return }
        
        var zeroPositionPointer = 0
        
        for (nonZeroPointer, num) in nums.enumerated() where num != 0  {
            swap(zeroPositionPointer, nonZeroPointer)
            zeroPositionPointer += 1
        }
        
        func swap(_ index1: Int, _ index2: Int) {
            let temp = nums[index1]
            nums[index1] = nums[index2]
            nums[index2] = temp
        }
    }
}

/*
Example
Input: nums = [0, 1, 0, 3, 12]
Output: nums = [1, 3, 12, 0, 0]

Approach: Two-Pointer Method
We'll use a two-pointer approach where one pointer (left) keeps track of the position of the last non-zero element found, and the other pointer (right) iterates through the array.

- left pointer (slow pointer): Keeps track of the last confirmed position of non-zero elements.
- right pointer (fast pointer): Used to explore each element in the array.

Steps for Execution
- Initialize left to 0. This pointer will keep track of where the next non-zero element should go.
- Iterate over the array with right pointer from index 0 to the end of the array.

For each element nums[right]:
- If nums[right] is non-zero:
- Swap nums[left] with nums[right]. This places the non-zero element at the current left position.
- Increment left by 1 to move to the next position for a non-zero element.
- After the loop ends, all non-zero elements will be at the start of the array in their original order, and the remaining elements will be zeroes at the end.

Step-by-Step Execution
- Let’s walk through an example with nums = [0, 1, 0, 3, 12].

Initial Array and Pointer Setup
Initial array: [0, 1, 0, 3, 12]
left = 0, right = 0

Iteration 1: right = 0
nums[right] is 0, so we do nothing and move right to the next position.

Iteration 2: right = 1
nums[right] is 1 (non-zero).
Swap nums[left] with nums[right].
Swap: [1, 0, 0, 3, 12] (1 moves to index 0)
Increment left to 1.
Move right to the next position.

Iteration 3: right = 2
nums[right] is 0, so we do nothing and move right to the next position.

Iteration 4: right = 3
nums[right] is 3 (non-zero).
Swap nums[left] with nums[right].
Swap: [1, 3, 0, 0, 12] (3 moves to index 1)
Increment left to 2.
Move right to the next position.

Iteration 5: right = 4
nums[right] is 12 (non-zero).
Swap nums[left] with nums[right].
Swap: [1, 3, 12, 0, 0] (12 moves to index 2)
Increment left to 3.
Move right to the next position.

Final Array
After completing the iteration, the array is: [1, 3, 12, 0, 0]. All non-zero elements are moved to the start of the array, and all zeros are moved to the end.

Complexity Analysis
Time Complexity: O(n), where n is the number of elements in nums, since we only iterate through the array once.


class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 1 else { return }
        
        var zeroPtr = 0
        var nonZeroPtr = 0
        
        for num in nums {
            if num != 0 {
                swap(zeroPtr, nonZeroPtr)
                zeroPtr += 1
            }
            
            nonZeroPtr += 1
        }
        
        func swap(_ index1: Int, _ index2: Int) {
            let temp = nums[index1]
            nums[index1] = nums[index2]
            nums[index2] = temp
        }
    }
}
*/

/*
class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        var currentZeroIndex = -1
        
        var currentIndex = 0 
        while currentIndex < nums.count {
            let currentIndexValue = nums[currentIndex]
            
            if currentIndexValue == 0 {
                currentZeroIndex = currentIndex
                
                var currentNonZeroIndex = currentZeroIndex
                for index in currentIndex+1..<nums.count {
                    if nums[index] != 0 {
                        currentNonZeroIndex = index
                        break
                    }
                }
                
                //swap
                nums[currentIndex] = nums[currentNonZeroIndex]
                nums[currentNonZeroIndex] = currentIndexValue
            }   
            
            currentIndex += 1
        }
    }
}
*/