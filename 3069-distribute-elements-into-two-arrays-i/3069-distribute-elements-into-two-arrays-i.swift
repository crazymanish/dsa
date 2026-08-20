class Solution {
    /**
     Problem Summary:
     Distribute elements into two arrays:
     - `firstArray` starts with `nums[0]`.
     - `secondArray` starts with `nums[1]`.
     - For each remaining number, append it to the array whose last element is larger.
     - If both last elements are equal, append to `secondArray`.
     Finally, concatenate both arrays.

     Strategy:
     Simulate the distribution process directly while tracking both arrays.

     Time Complexity:
     O(n), where n is the number of elements in `nums`.

     Space Complexity:
     O(n) for the two result arrays.
     */
    func resultArray(_ nums: [Int]) -> [Int] {
        var firstArray = [nums[0]]
        var secondArray = [nums[1]]

        // Distribute each remaining number based on the last elements.
        for index in 2..<nums.count {
            if firstArray.last! > secondArray.last! {
                firstArray.append(nums[index])
            } else {
                // This also handles equality, where secondArray should be chosen.
                secondArray.append(nums[index])
            }
        }

        // The final result is firstArray followed by secondArray.
        return firstArray + secondArray
    }
}