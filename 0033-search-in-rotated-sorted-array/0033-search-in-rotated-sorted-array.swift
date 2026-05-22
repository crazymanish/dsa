class Solution {
    /**
     Problem Summary:
     Given a rotated sorted array `nums` and an integer `target`, return the index of `target`
     if it exists in the array. Otherwise, return `-1`.

     Strategy:
     Use a recursive search over the given index range.
     At each step:
     - Check the middle value.
     - Search the left side first.
     - If not found, search the right side.
     - The extra rotated-boundary check is kept from the original logic, although the normal
       left/right recursive search already covers both sides.

     Time Complexity:
     O(n), because in the worst case both halves may be searched.

     Space Complexity:
     O(log n) average recursion depth for balanced calls, but up to O(n) in recursive call overhead
     depending on the traversal path.
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        let lastIndex = nums.count - 1

        func searchInRotatedArray(_ leftIndex: Int, _ rightIndex: Int) -> Int {
            // Base case: target was not found in this search range.
            if leftIndex > rightIndex {
                return -1
            }

            let middleIndex = leftIndex + (rightIndex - leftIndex) / 2
            let middleValue = nums[middleIndex]

            // Target found at the current middle index.
            if middleValue == target {
                return middleIndex
            }

            // Search the left half first.
            var foundIndex = searchInRotatedArray(leftIndex, middleIndex - 1)

            // If the target was not found on the left, search the right half.
            if foundIndex == -1 {
                foundIndex = searchInRotatedArray(middleIndex + 1, rightIndex)
            }

            // Preserve the original rotated-boundary check.
            // Note: this is redundant because the right half was already searched above.
            if foundIndex == -1 {
                let nextValue = middleIndex + 1 <= lastIndex ? nums[middleIndex + 1] : Int.max

                if nextValue < middleValue {
                    foundIndex = searchInRotatedArray(middleIndex + 1, rightIndex)
                }
            }

            return foundIndex
        }

        return searchInRotatedArray(0, lastIndex)
    }
}