class Solution {
    func numTilePossibilities(_ tiles: String) -> Int {
        let lastTileIndex = tiles.count - 1
        var tileArray = Array(tiles)
        var uniquePermutations: Set<String> = []
        var currentPermutation: String = ""

        func findPermutations(_ currentTileIndex: Int) {
            if currentTileIndex > lastTileIndex { return }

            for permutationIndex in currentTileIndex...lastTileIndex {
                swap(currentTileIndex, permutationIndex)

                // Build the current permutation
                let currentTile = String(tileArray[currentTileIndex])
                currentPermutation.append(currentTile)
                uniquePermutations.insert(currentPermutation)

                // Explore further permutations
                findPermutations(currentTileIndex + 1)

                // Backtrack: Undo the swap and remove the last character
                swap(currentTileIndex, permutationIndex)
                currentPermutation.removeLast()
            }
        }

        func swap(_ firstIndex: Int, _ secondIndex: Int) { // Pass array by reference
            let temp = tileArray[firstIndex]
            tileArray[firstIndex] = tileArray[secondIndex]
            tileArray[secondIndex] = temp
        }

        findPermutations(0) // Start generating permutations from the first tile
        return uniquePermutations.count
    }
}