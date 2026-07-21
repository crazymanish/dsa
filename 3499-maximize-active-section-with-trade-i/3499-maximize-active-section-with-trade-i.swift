final class Solution {
    /*
     Problem Summary:
     Return the maximum number of active sections (`1`s) after one valid trade.

     Strategy:
     - Run-length encode the binary string into alternating block lengths.
     - Build prefix sums for active (`1`) blocks only.
     - For each eligible active block, combine its neighbouring inactive blocks
       with the active sections already counted.
     - Keep the best result.

     Time Complexity: O(n)
     Space Complexity: O(n)
     */

    func maxActiveSectionsAfterTrade(_ s: String) -> Int {
        let activeSectionCount = s.filter { $0 == "1" }.count

        // A valid trade requires at least three sections.
        if s.count < 3 { return activeSectionCount }

        // No active section exists to participate in a trade.
        guard activeSectionCount > 0 else { return 0 }

        // The sentinel ensures that the final block is processed.
        let characters = Array(s) + ["1"]

        var blockCounts: [Int] = []
        var previousCharacter: Character = "1"
        var currentBlockLength = 0

        // Store the lengths of consecutive equal-character blocks.
        for character in characters {
            if character == previousCharacter {
                currentBlockLength += 1
            } else {
                blockCounts.append(currentBlockLength)
                currentBlockLength = 1
            }

            previousCharacter = character
        }

        // Remove the artificial sentinel from the final block.
        blockCounts.append(currentBlockLength - 1)

        /*
         Even indices represent `1` blocks.
         Odd indices represent `0` blocks.

         The prefix sum lets us quickly count active sections outside
         the blocks involved in the current trade.
         */
        var activePrefixSums = Array(repeating: 0, count: blockCounts.count)
        activePrefixSums[0] = blockCounts[0]

        for index in 1..<blockCounts.count {
            activePrefixSums[index] = activePrefixSums[index - 1]

            // Only even-indexed blocks contain active sections.
            if index.isMultiple(of: 2) {
                activePrefixSums[index] += blockCounts[index]
            }
        }

        var maximumActiveSections = activeSectionCount

        // Each candidate active block must have an inactive block on its right.
        for activeBlockIndex in stride(from: 2, to: blockCounts.count, by: 2) {
            let rightInactiveBlockIndex = activeBlockIndex + 1

            guard rightInactiveBlockIndex < blockCounts.count else {
                continue
            }

            /*
             Include:
             - Active sections before the selected region
             - The left inactive block
             - The current active block
             - The right inactive block
             */
            let activeSectionsBeforeTrade =
                activePrefixSums[activeBlockIndex - 1] +
                blockCounts[activeBlockIndex - 1] +
                blockCounts[activeBlockIndex] +
                blockCounts[rightInactiveBlockIndex]

            // Add active sections after the selected region.
            let activeSectionsAfterTrade =
                activePrefixSums[blockCounts.count - 1] -
                activePrefixSums[rightInactiveBlockIndex]

            maximumActiveSections = max(
                maximumActiveSections,
                activeSectionsBeforeTrade + activeSectionsAfterTrade
            )
        }

        return maximumActiveSections
    }
}