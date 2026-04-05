/**
 Problem Summary:
 Determine whether a robot returns to the origin (0,0) after executing a sequence
 of moves. Each move is represented by a character:
 - 'U' → move up
 - 'D' → move down
 - 'L' → move left
 - 'R' → move right

 Strategy:
 Track the robot’s position using two variables:
 - horizontalPosition (x-axis)
 - verticalPosition (y-axis)

 Iterate through each move and update the position accordingly.
 At the end, check if both coordinates return to zero.

 Time Complexity:
 O(n) — we process each move once

 Space Complexity:
 O(1) — only constant extra space is used
 */

class Solution {
    func judgeCircle(_ moves: String) -> Bool {
        // Track horizontal (x-axis) and vertical (y-axis) positions
        var horizontalPosition = 0
        var verticalPosition = 0
        
        // Process each move in the input string
        for move in moves {
            switch move {
            case "U":
                // Move up → increase vertical position
                verticalPosition += 1
                
            case "D":
                // Move down → decrease vertical position
                verticalPosition -= 1
                
            case "L":
                // Move left → decrease horizontal position
                horizontalPosition -= 1
                
            case "R":
                // Move right → increase horizontal position
                horizontalPosition += 1
                
            default:
                // Ignore invalid characters (not expected per constraints)
                continue
            }
        }
        
        // Robot returns to origin only if both coordinates are zero
        return horizontalPosition == 0 && verticalPosition == 0
    }
}