class Solution {
    /**
     Problem Summary:
     Remove both the minimum and maximum elements from the array.
     In one deletion, we can remove an element only from the front or back.
     Return the minimum number of deletions required.

     Strategy:
     1. Find the indices of the minimum and maximum elements.
     2. Consider the three possible deletion strategies:
        - Remove both from the left.
        - Remove both from the right.
        - Remove one from the left and the other from the right.
     3. Return the minimum cost among these strategies.

     Time Complexity: O(n)
     - One pass is used to locate the minimum and maximum elements.

     Space Complexity: O(1)
     - Only a constant number of variables are used.
     */
    func minimumDeletions(_ nums: [Int]) -> Int {
        var minimumValue = Int.max
        var maximumValue = Int.min
        var minimumIndex = 0
        var maximumIndex = 0

        // Find the positions of the minimum and maximum elements.
        for (index, value) in nums.enumerated() {
            if value < minimumValue {
                minimumValue = value
                minimumIndex = index
            }

            if value > maximumValue {
                maximumValue = value
                maximumIndex = index
            }
        }

        // Number of deletions needed to remove each element
        // when deleting exclusively from either side.
        let minimumFromLeft = minimumIndex + 1
        let maximumFromLeft = maximumIndex + 1

        let minimumFromRight = nums.count - minimumIndex
        let maximumFromRight = nums.count - maximumIndex

        // Strategy 1: Delete from the left until both elements are removed.
        let removeBothFromLeft = max(minimumFromLeft, maximumFromLeft)

        // Strategy 2: Delete from the right until both elements are removed.
        let removeBothFromRight = max(minimumFromRight, maximumFromRight)

        // Strategy 3: Delete one element from each side.
        let removeMinimumLeftMaximumRight =
            minimumFromLeft + maximumFromRight

        let removeMaximumLeftMinimumRight =
            maximumFromLeft + minimumFromRight

        return min(
            removeBothFromLeft,
            removeBothFromRight,
            removeMinimumLeftMaximumRight,
            removeMaximumLeftMinimumRight
        )
    }
}