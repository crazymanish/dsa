/**
 Problem Summary:
 Given an array `nums`, define a rotation function:
 F(k) = sum(i * nums[(i + k) % n]) for all i in [0, n-1]

 The task is to compute the maximum value of F(k) for all rotations k.

 Strategy:
 - Instead of recomputing F(k) from scratch for every rotation (O(n^2)),
   we use a mathematical recurrence relation:

   F(k) = F(k-1) + totalSum - n * nums[n - k]

 - Steps:
   1. Compute total sum of the array.
   2. Compute F(0) directly.
   3. Iteratively compute F(k) using the recurrence.
   4. Track the maximum value.

 Time Complexity:
 O(n) — single pass to compute sum and initial value, then one pass for rotations.

 Space Complexity:
 O(1) — no extra space needed apart from variables.
*/
class Solution {
    func maxRotateFunction(_ nums: [Int]) -> Int {
        let n = nums.count
        
        guard n > 1 else { return 0 }

        // Total sum of all elements
        let totalSum = nums.reduce(0, +)

        // Compute F(0): sum of i * nums[i]
        var currentRotationValue = 0
        for index in 0..<n {
            currentRotationValue += index * nums[index]
        }

        var maxRotationValue = currentRotationValue

        // Compute subsequent rotation values using recurrence relation
        for rotation in 1..<n {
            // Element that moves from end to front in this rotation
            let shiftedElement = nums[n - rotation]

            // Apply recurrence:
            // F(k) = F(k-1) + totalSum - n * shiftedElement
            currentRotationValue = currentRotationValue + totalSum - n * shiftedElement

            // Track maximum value
            maxRotationValue = max(maxRotationValue, currentRotationValue)
        }

        return maxRotationValue
    }
}