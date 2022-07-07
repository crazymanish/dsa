// https://leetcode.com/problems/squares-of-a-sorted-array

class Solution {
    // Follow up: Squaring each element and sorting the new array is very trivial, 
    // could you find an O(n) solution using a different approach?
    //
    // Yes, using two pointers.
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var output: [Int] = []
        var leftPointer = 0
        var rightPointer = nums.count-1
        
        while leftPointer <= rightPointer {
            let leftSquareRoot = nums[leftPointer] * nums[leftPointer]
            let rightSquareRoot = nums[rightPointer] * nums[rightPointer]
            
            if leftSquareRoot > rightSquareRoot {
                output.insert(leftSquareRoot, at: 0)
                
                leftPointer += 1
            } else {
                output.insert(rightSquareRoot, at: 0)
                
                rightPointer -= 1
            }
        }
        
        return output
    }
}