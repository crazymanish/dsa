class Solution {
    func coloredCells(_ n: Int) -> Int {
        // Calculate the number of colored cells using the formula: 2 * n * (n - 1) + 1
        return 2 * n * (n - 1) + 1
    }
}