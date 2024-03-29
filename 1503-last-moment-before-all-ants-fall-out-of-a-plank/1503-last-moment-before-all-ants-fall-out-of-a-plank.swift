class Solution {
    func getLastMoment(_ n: Int, _ left: [Int], _ right: [Int]) -> Int {
        let maxN = n
        let rhs = (maxN) - (right.min() ?? maxN)
        
        return max(left.max() ?? 0, rhs)
    }
}