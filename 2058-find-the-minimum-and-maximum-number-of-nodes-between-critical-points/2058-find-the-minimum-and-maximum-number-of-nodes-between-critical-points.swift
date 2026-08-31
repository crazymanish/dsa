/**
 Problem Summary:
 Given the head of a linked list, find all critical points.
 A critical point is a node that is either:
 - A local maximum: greater than both adjacent nodes.
 - A local minimum: smaller than both adjacent nodes.

 Return:
 - The minimum distance between any two critical points.
 - The maximum distance between any two critical points.

 If there are fewer than two critical points, return [-1, -1].

 Strategy:
 Traverse the linked list once while keeping three consecutive nodes:
 `previous`, `current`, and `next`.

 When `current` is a critical point:
 - Store the position of the first critical point.
 - Compute the distance from the previous critical point to update
   the minimum distance.
 - Track the most recent critical point.

 The maximum distance is simply the distance between the first and
 last critical points.

 Time Complexity:
 O(n), where n is the number of nodes.

 Space Complexity:
 O(1), since only a constant amount of extra state is maintained.
 */
class Solution {
    func nodesBetweenCriticalPoints(_ head: ListNode?) -> [Int] {
        // A critical point needs both a previous and next node.
        guard var previous = head,
              var current = previous.next else {
            return [-1, -1]
        }

        // `current` starts at the second node.
        var currentIndex = 1

        var firstCriticalIndex = -1
        var previousCriticalIndex = -1
        var minimumDistance = Int.max

        while let next = current.next {
            // The current node is critical if it is strictly greater
            // than both neighbors or strictly smaller than both.
            let isLocalMaximum =
                current.val > previous.val && current.val > next.val

            let isLocalMinimum =
                current.val < previous.val && current.val < next.val

            if isLocalMaximum || isLocalMinimum {
                if firstCriticalIndex == -1 {
                    // Remember the first critical point so we can
                    // calculate the maximum distance at the end.
                    firstCriticalIndex = currentIndex
                } else {
                    // Consecutive critical points give the smallest
                    // possible distance candidates.
                    let distance = currentIndex - previousCriticalIndex
                    minimumDistance = min(minimumDistance, distance)
                }

                previousCriticalIndex = currentIndex
            }

            // Advance the three-node traversal window.
            previous = current
            current = next
            currentIndex += 1
        }

        // Fewer than two critical points were found.
        guard firstCriticalIndex != previousCriticalIndex else {
            return [-1, -1]
        }

        let maximumDistance =
            previousCriticalIndex - firstCriticalIndex

        return [minimumDistance, maximumDistance]
    }
}