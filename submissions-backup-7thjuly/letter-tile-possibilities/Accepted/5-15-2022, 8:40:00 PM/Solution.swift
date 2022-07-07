// https://leetcode.com/problems/letter-tile-possibilities

class Solution {
    func numTilePossibilities(_ tiles: String) -> Int {
        let lastIndex = tiles.count-1
        var tilesArray = Array(tiles)
        var allPermutations: Set<String> = []
        var currentPermutation: String = ""
        
        func findPermutations(_ currentIndex: Int) {
            if currentIndex > lastIndex { return }
            
            for permutationIndex in currentIndex...lastIndex {
                swap(currentIndex, permutationIndex)
                
                let currentIndexValue = String(tilesArray[currentIndex])
                currentPermutation.append(currentIndexValue)
                allPermutations.insert(currentPermutation)
                
                findPermutations(currentIndex+1)
                
                // backtracking
                swap(currentIndex, permutationIndex)
                currentPermutation.removeLast()
            }
        }
        
        func swap(_ firstIndex: Int, _ secondIndex: Int) {
            let temp = tilesArray[firstIndex]
            tilesArray[firstIndex] = tilesArray[secondIndex]
            tilesArray[secondIndex] = temp
        }
        
        findPermutations(0)
        return allPermutations.count
    }
}
