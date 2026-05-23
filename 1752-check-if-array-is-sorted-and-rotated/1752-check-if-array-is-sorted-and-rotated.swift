class Solution {
    /**
     Problem Summary:
     Determine whether the array was originally sorted in non-decreasing order and then rotated
     some number of positions.

     Strategy:
     In a sorted rotated array, there can be at most one place where the order "drops",
     meaning nums[i] > nums[i + 1]. We also compare the last element back to the first
     element to handle the circular rotation point.

     Time Complexity:
     O(n), where n is the number of elements in nums.

     Space Complexity:
     O(1), since only a counter is used.
     */
    func check(_ nums: [Int]) -> Bool {
        var dropCount = 0
        let count = nums.count

        for index in 0..<count {
            let nextIndex = (index + 1) % count

            // A drop means the sorted order breaks at this point.
            // In a valid sorted-and-rotated array, this can happen at most once.
            if nums[index] > nums[nextIndex] {
                dropCount += 1
            }

            // More than one drop means the array cannot be sorted by rotation.
            if dropCount > 1 {
                return false
            }
        }

        return true
    }
}