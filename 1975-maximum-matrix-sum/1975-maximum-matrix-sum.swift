class Solution {
    func maxMatrixSum(_ matrix: [[Int]]) -> Int {
        let nums = matrix.flatMap { $0 }
        let absNums = nums.map(abs)
        let absSum = absNums.reduce(0, +)
        
        if nums.filter { $0 < 0 }.count.isMultiple(of: 2) {
            return absSum
        } else {
            return absSum - 2 * absNums.min()!
        }
    }
}