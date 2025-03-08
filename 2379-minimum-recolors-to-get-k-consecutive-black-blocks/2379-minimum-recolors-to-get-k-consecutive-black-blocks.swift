class Solution {
    func minimumRecolors(_ blocks: String, _ k: Int) -> Int {
        let blockColors = Array(blocks) // Convert the string to an array of characters
        var minRecoloringOperations = Int.max // Initialize the minimum recoloring operations to the maximum possible value

        // Iterate through all possible starting positions for a window of size k
        for windowStart in 0...(blockColors.count - k) {
            var recoloringOperationsForCurrentWindow = 0 // Count recoloring operations for the current window

            // Iterate through the blocks in the current window
            for blockIndex in windowStart..<(windowStart + k) {
                if blockColors[blockIndex] == "W" {
                    recoloringOperationsForCurrentWindow += 1 // Increment count if the block is white
                }
            }

            // Update the minimum recoloring operations if the current window requires fewer operations
            minRecoloringOperations = min(minRecoloringOperations, recoloringOperationsForCurrentWindow)
        }

        // Return the minimum recoloring operations, or 0 if no recoloring is needed
        return minRecoloringOperations == Int.max ? 0 : minRecoloringOperations
    }
}