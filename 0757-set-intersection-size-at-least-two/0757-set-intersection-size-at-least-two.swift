/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • Let n = intervals.count, and m = number of selected points.
///   • Sorting intervals:      O(n log n)
///   • For each interval:
///       - Filtering the set:  O(m)
///       - Adding up to 2 pts: O(1) amortized
///   • Overall worst-case:     O(n * m) ≈ O(n²) when m grows with n.
///
/// Space Complexity:
///   • O(m) for the set of selected points (at most 2 per interval, so O(n)).
///
/// Description:
///   We sort intervals by their end point. For each interval, we count how
///   many already-selected points fall inside it. If fewer than 2, we greedily
///   add points starting from the interval's end and moving left until we've
///   added enough to ensure the interval has at least two points.
/// ---------------------------------------------------------------------------

class Solution {
    func intersectionSizeTwo(_ intervals: [[Int]]) -> Int {
        // Sort intervals by their end coordinate (ascending)
        let sortedIntervals = intervals.sorted { $0[1] < $1[1] }
        
        // Set of all selected points
        var selectedPoints = Set<Int>()

        for interval in sortedIntervals {
            let intervalStart = interval[0]
            let intervalEnd = interval[1]

            // Count how many selected points fall inside [intervalStart, intervalEnd]
            let pointsInInterval = selectedPoints
                .filter { $0 >= intervalStart && $0 <= intervalEnd }
                .count

            // If fewer than 2 points cover this interval, add more
            if pointsInInterval < 2 {
                let pointsNeeded = 2 - pointsInInterval
                var candidatePoint = intervalEnd
                var pointsAdded = 0

                // Greedily add points from right (intervalEnd) to left
                while pointsAdded < pointsNeeded {
                    if !selectedPoints.contains(candidatePoint) {
                        selectedPoints.insert(candidatePoint)
                        pointsAdded += 1
                    }
                    candidatePoint -= 1
                }
            }
        }

        return selectedPoints.count
    }
}
