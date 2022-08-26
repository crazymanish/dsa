class Solution {
    func reorderedPowerOf2(_ n: Int) -> Bool {
        let nSortedHash = String(n).sorted().hashValue
        // because log2(10^9) < 30
        for exp in 0 ... 30 where nSortedHash == String(1 << exp).sorted().hashValue {
            return true
        }
        return false
    }
}