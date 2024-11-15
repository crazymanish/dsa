class Solution {
    func findLengthOfShortestSubarray(_ arr: [Int]) -> Int {
        let n = arr.count

        // Find "l" and "r", such that "arr" is non decreasing in ranges
        // 0...l and r..<n
        var (l, r) = (0, n - 1)
        while l < n - 1 && arr[l] <= arr[l + 1] { l += 1 }
        while r > 0 && arr[r - 1] <= arr[r] { r -= 1 }

        // We could remove the first "r" elements, since the remaining
        // array (r..<n) is non decreasing.
        var res = r

        // Or we could keep some part of the prefix 0...l and continue
        // somewhere in r..<n, in such a way that the concatenation of 
        // the suffix and prefix is non decreasing.
        for i in 0...l {
            let prefixLength = i + 1
            let suffixLength = n - firstIndex(lowerBound: arr[i], startingAtIndex: max(r, i + 1))
            res = min(res, n - prefixLength - suffixLength)
        }
        return res

        // Returns the first index "i" such that "i >= startingAtIndex" and "arr[i] >= val".
        func firstIndex(lowerBound val: Int, startingAtIndex index: Int) -> Int {
            var (lo, hi) = (index, n - 1)
            var res = hi + 1
            while lo <= hi {
                let mid = lo + (hi - lo) / 2
                if arr[mid] < val {
                    lo = mid + 1
                } else {
                    res = mid
                    hi = mid - 1
                }
            }
            return res
        }
    }
}
