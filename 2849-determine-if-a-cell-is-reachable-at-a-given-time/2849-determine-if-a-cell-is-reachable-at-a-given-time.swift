class Solution {
    func isReachableAtTime(_ sx: Int, _ sy: Int, _ fx: Int, _ fy: Int, _ t: Int) -> Bool {
        let minDist = max(abs(sx - fx), abs(sy - fy))
        return minDist <= t && !(minDist == 0 && t == 1)
    }
}