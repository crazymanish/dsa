// Time Complexity: O(N + K_total + B_total)
//   - N: Number of boxes.
//   - K_total: Total number of key entries across all `keysInBox` arrays.
//   - B_total: Total number of box entries across all `boxesInBox` arrays.
//   - Initialization of `keyIsAvailableForBox`, `boxIsPossessed`: O(N).
//   - Initial population of `currentRoundOpenableBoxes`: O(N).
//   - The `while` loop:
//     - Each box can be added to `currentRoundOpenableBoxes` (and thus processed) at most once.
//       This is because once a box's candies are collected, it's effectively "used up" in terms of candy collection,
//       and the logic for adding to `nextRoundOpenableBoxes` relies on a change in status (new key or new box possession).
//     - When a box `boxToOpenIndex` is processed:
//       - Adding `candiesPerBox[boxToOpenIndex]` is O(1).
//       - Iterating through `keysInBox[boxToOpenIndex]`: Sum of lengths of all `keysInBox[i]` is K_total.
//       - Iterating through `boxesInBox[boxToOpenIndex]`: Sum of lengths of all `boxesInBox[i]` is B_total.
//     - Operations inside these inner loops are O(1).
//   - Thus, the total time for the `while` loop and its contents is O(N (for processing each box once) + K_total + B_total).
//   - Overall: O(N) + O(N) + O(N + K_total + B_total) = O(N + K_total + B_total).
//
// Space Complexity: O(N)
//   - `keyIsAvailableForBox`: O(N).
//   - `boxIsPossessed`: O(N).
//   - `currentRoundOpenableBoxes` (and `nextRoundOpenableBoxes`): In the worst case, can hold up to O(N) box indices.
//   - Overall: O(N).

class Solution {
    func maxCandies(_ initialBoxStatus: [Int], _ candiesPerBox: [Int], _ keysInBox: [[Int]], _ boxesInBox: [[Int]], _ initiallyPossessedBoxes: [Int]) -> Int {
        let numberOfBoxes = initialBoxStatus.count

        // `keyIsAvailableForBox[i]` is true if we have the key for box `i`.
        // A key is available if the box's initial status is 1 (unlocked) or if we find its key.
        var keyIsAvailableForBox = Array(repeating: false, count: numberOfBoxes)
        for i in 0..<numberOfBoxes {
            if initialBoxStatus[i] == 1 {
                keyIsAvailableForBox[i] = true
            }
        }

        // `boxIsPossessed[i]` is true if we physically have box `i`.
        // We possess a box if it's in `initiallyPossessedBoxes` or if we find it inside another opened box.
        var boxIsPossessed = Array(repeating: false, count: numberOfBoxes)
        for boxIndex in initiallyPossessedBoxes {
            boxIsPossessed[boxIndex] = true
        }

        // Queue for boxes that can be opened in the current round.
        // A box can be opened if we possess it AND have its key.
        var currentRoundOpenableBoxes: [Int] = []
        for boxIndex in 0..<numberOfBoxes {
            if keyIsAvailableForBox[boxIndex] && boxIsPossessed[boxIndex] {
                currentRoundOpenableBoxes.append(boxIndex)
            }
        }

        var totalCandiesCollected = 0

        // Process boxes round by round. In each round, open all currently openable boxes.
        while !currentRoundOpenableBoxes.isEmpty {
            var nextRoundOpenableBoxes: [Int] = [] // Collect boxes that become openable for the next round.

            for boxToOpenIndex in currentRoundOpenableBoxes {
                // Collect candies from the currently opened box.
                totalCandiesCollected += candiesPerBox[boxToOpenIndex]

                // Process keys found in the `boxToOpenIndex`.
                for boxIndexOfFoundKey in keysInBox[boxToOpenIndex] {
                    // If we didn't have this key before, mark it as available.
                    if !keyIsAvailableForBox[boxIndexOfFoundKey] {
                        keyIsAvailableForBox[boxIndexOfFoundKey] = true
                        // If we also possess the box for this newly found key, it can be opened in the next round.
                        if boxIsPossessed[boxIndexOfFoundKey] {
                            nextRoundOpenableBoxes.append(boxIndexOfFoundKey)
                        }
                    }
                }

                // Process boxes found inside the `boxToOpenIndex`.
                for indexOfFoundBox in boxesInBox[boxToOpenIndex] {
                    // If we didn't possess this box before, mark it as possessed.
                    if !boxIsPossessed[indexOfFoundBox] {
                        boxIsPossessed[indexOfFoundBox] = true
                        // If we also have the key for this newly possessed box, it can be opened in the next round.
                        if keyIsAvailableForBox[indexOfFoundBox] {
                            nextRoundOpenableBoxes.append(indexOfFoundBox)
                        }
                    }
                }
            }
            // Move to the next round with the newly openable boxes.
            currentRoundOpenableBoxes = nextRoundOpenableBoxes
        }
        return totalCandiesCollected
    }
}
