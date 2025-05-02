class Solution {
    /**
     * Simulates the falling of dominoes based on initial pushes ('L' or 'R').
     * Dominoes represented by '.' remain standing unless pushed.
     * 'L' pushes the domino to its left.
     * 'R' pushes the domino to its right.
     * If a domino is pushed from both sides, it remains standing.
     * If pushed from one side, it falls in that direction, potentially pushing the next one.
     *
     * - Parameter dominoes: A string representing the initial state ("L", "R", ".").
     * - Returns: A string representing the final state of the dominoes.
     *
     * - Time Complexity: O(N), where N is the length of the input `dominoes` string.
     * - Creating the padded array: O(N).
     * - The main loop iterates through the padded array once (N+2 elements): O(N).
     * - Inside the loop, processing each segment involves appending characters.
     * Each original domino position is processed and appended exactly once
     * across all segments. Total appending work: O(N).
     * - Converting the final character array to a string: O(N).
     * - Overall: O(N) + O(N) + O(N) = O(N).
     *
     * - Space Complexity: O(N).
     * - Storing the `paddedDominoesArray`: O(N).
     * - Storing the `finalStateChars` array: O(N).
     * - Overall: O(N).
     */
    func pushDominoes(_ dominoes: String) -> String {
        // Pad the input string with 'L' at the start and 'R' at the end.
        // These sentinels simplify handling edge cases, ensuring every '.' segment
        // is always bounded by non-'.' characters.
        let paddedDominoesArray: [Character] = ["L"] + Array(dominoes) + ["R"]
        // Array to build the final state character by character.
        var finalStateChars: [Character] = []
        // `leftBoundIndex` marks the index of the start of the current segment (an 'L' or 'R').
        var leftBoundIndex = 0

        // Iterate through the padded array to find segments of '.' dominoes.
        // `rightBoundIndex` searches for the end of the current segment (the next 'L' or 'R').
        for rightBoundIndex in 1..<paddedDominoesArray.endIndex {
            // Skip standing dominoes until we find a boundary ('L' or 'R').
            if paddedDominoesArray[rightBoundIndex] == "." { continue }

            // --- Process the segment between leftBoundIndex and rightBoundIndex ---

            // Append the left boundary character itself (unless it's the initial sentinel).
            // The initial 'L' sentinel is not part of the original string.
            if leftBoundIndex > 0 {
                finalStateChars.append(paddedDominoesArray[leftBoundIndex])
            }

            // Calculate the number of '.' dominoes between the boundaries.
            let segmentLength = rightBoundIndex - leftBoundIndex - 1
            let leftBoundaryChar = paddedDominoesArray[leftBoundIndex]
            let rightBoundaryChar = paddedDominoesArray[rightBoundIndex]

            // Determine the state of dominoes within the segment based on boundaries.
            if leftBoundaryChar == rightBoundaryChar {
                // Case 1: L...L or R...R
                // All dominoes in the segment fall in the same direction as the boundaries.
                for _ in 0..<segmentLength {
                    finalStateChars.append(leftBoundaryChar) // Append 'L' or 'R'
                }
            } else if leftBoundaryChar == "L" && rightBoundaryChar == "R" {
                // Case 2: L...R
                // Pushes from both ends cancel out in the middle.
                // All dominoes in the segment remain standing.
                for _ in 0..<segmentLength {
                    finalStateChars.append(".") // Append '.'
                }
            } else { // Case 3: R...L
                // Dominoes fall towards the middle from both sides.
                let halfSegment = segmentLength / 2
                // First half falls right ('R').
                for _ in 0..<halfSegment {
                    finalStateChars.append("R")
                }
                // If the segment has an odd length, the middle one remains standing.
                if segmentLength % 2 == 1 {
                    finalStateChars.append(".")
                }
                // Second half falls left ('L').
                for _ in 0..<halfSegment {
                    finalStateChars.append("L")
                }
            }

            // Move the left boundary to the start of the next segment.
            leftBoundIndex = rightBoundIndex
        }

        // Convert the final character array back to a string.
        return String(finalStateChars)
    }
}
