class Solution {
    /**
     Problem Summary:
     Rearrange the array around a given pivot while preserving relative order:
     - All numbers smaller than `pivot` come first.
     - All numbers equal to `pivot` come next.
     - All numbers greater than `pivot` come last.

     Strategy:
     Use three passes:
     1. Add all values smaller than the pivot.
     2. Add all values equal to the pivot.
     3. Add all values greater than the pivot.

     This keeps the relative order stable for each group and avoids reversing.

     Time Complexity: O(n)
     Space Complexity: O(n)
     */
    func pivotArray(_ nums: [Int], _ pivot: Int) -> [Int] {
        var result: [Int] = []
        result.reserveCapacity(nums.count)

        // Add all values smaller than the pivot first.
        for number in nums where number < pivot {
            result.append(number)
        }

        // Add all pivot values in the middle.
        for number in nums where number == pivot {
            result.append(number)
        }

        // Add all values greater than the pivot last.
        for number in nums where number > pivot {
            result.append(number)
        }

        return result
    }
}