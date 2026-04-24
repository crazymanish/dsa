/**
 Problem Summary:
 Given a string `moves` consisting of 'L', 'R', and '_' (unknown moves),
 determine the maximum possible distance from the origin after optimally
 replacing each '_' with either 'L' or 'R'.

 Strategy:
 - Count occurrences of 'L', 'R', and '_'.
 - The current displacement without '_' is |L - R|.
 - Each '_' can be used to increase the distance by 1 by choosing the
   direction that extends the current imbalance.
 - Therefore, final answer = |L - R| + numberOfUnderscores.

 Key Insight:
 All '_' moves should be used to amplify the dominant direction to maximize distance.

 Time Complexity:
 O(n) — single pass to count characters

 Space Complexity:
 O(1) — constant extra space
 */

class Solution {
    func furthestDistanceFromOrigin(_ moves: String) -> Int {
        var leftMoveCount = 0
        var rightMoveCount = 0
        var unknownMoveCount = 0
        
        // Count occurrences of each move type
        for move in moves {
            if move == "L" {
                leftMoveCount += 1
            } else if move == "R" {
                rightMoveCount += 1
            } else {
                // '_' can be assigned optimally later
                unknownMoveCount += 1
            }
        }
        
        // Base distance from fixed moves + contribution from all flexible moves
        return abs(leftMoveCount - rightMoveCount) + unknownMoveCount
    }
}