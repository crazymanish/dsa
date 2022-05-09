class Solution {
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var allCombinations: [[Int]] = []
        var currentCombination: [Int] = []

        func findCombinations(_ currentNumber: Int) {
            if currentCombination.count == k {
                allCombinations.append(currentCombination)
                return
            }

            if currentNumber > n { return }

            for number in currentNumber...n {
                currentCombination.append(number)

                findCombinations(number+1)

                currentCombination.removeLast() // backtracking
            }
        }

        findCombinations(1)
        return allCombinations
    }
}
