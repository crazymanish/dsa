// Time Complexity: O(N * K * M³)
// where N is the count of nums, K is the initial k, and M is the initial m.
// The DP state is defined by (m, k, i, flag). The size of these parameters are
// M, K, N, and M (the flag/carry can grow up to M). The transition inside the
// DFS involves a loop of size M. This gives a complexity of O(N * K * M * M * M).
// Given the constraints (N, K, M <= 30), this is feasible.
//
// Space Complexity: O(N * K * M²)
// The space is dominated by the memoization cache, which stores the results for
// each state. The number of states is O(N * K * M * M). The pre-computed
// combinations table and recursion stack use less space.
final class Solution {
    // A large prime modulus for performing calculations.
    static let MOD: Int64 = 1_000_000_007

    func magicalSum(_ m: Int, _ k: Int, _ nums: [Int]) -> Int {
        // Pre-compute binomial coefficients C(n, k) using Pascal's triangle.
        // c[i][j] will store "i choose j". This is used to calculate the number of
        // ways to assign items to the current number.
        var c = Array(repeating: Array(repeating: Int64(0), count: 31), count: 31)
        for i in 1...30 {
            c[i][0] = 1
            c[i][i] = 1
            if i > 1 {
                for j in 1...(i / 2) {
                    let val = (c[i - 1][j - 1] + c[i - 1][j]) % Solution.MOD
                    c[i][j] = val
                    c[i][i - j] = val // Use symmetry: C(n, k) = C(n, n-k)
                }
            }
        }

        // `memo` is our cache for the dynamic programming results to avoid re-computation.
        var memo = [String: Int64]()

        // This is a recursive helper function using a digit DP approach.
        // It calculates the number of ways to assign `m` items to `nums[i...]`
        // such that the final sum has `k` set bits, given a carry-over `flag`.
        func dfs(_ m: Int, _ k: Int, _ i: Int, _ flag: UInt32) -> Int64 {
            let key = "\(m),\(k),\(i),\(flag)"
            if let res = memo[key] {
                return res
            }

            // `bz` is the number of set bits from the final carry-over.
            let bz = Int(flag.nonzeroBitCount)
            // Pruning: if it's impossible to reach `k` set bits, return 0.
            if m < 0 || k < 0 || m + bz < k {
                return 0
            }
            // Base case: No items left to assign. Success if the carry-over bits match `k`.
            if m == 0 {
                return (k == bz) ? 1 : 0
            }
            // Base case: No numbers left in `nums`, but still items to assign.
            if i >= nums.count {
                return 0
            }

            var ans: Int64 = 0
            var powX: Int64 = 1
            let x = Int64(nums[i])

            // Iterate through all possibilities: assign `f` items (from 0 to `m`) to `nums[i]`.
            for f in 0...m {
                // `perm` is the number of ways to make this choice, weighted by `(nums[i])^f`.
                // c[m][f] is the number of ways to choose `f` items from the remaining `m`.
                let perm = (c[m][f] * powX) % Solution.MOD
                
                // === Digit DP Logic for the sum's binary representation ===
                // The `flag` acts as a carry-in from less significant bits. `f` is added.
                let newFlag = flag + UInt32(f)
                // The current bit of the total sum is the least significant bit of `newFlag`.
                let bitSet = Int(newFlag & 1)
                // The carry-out to the next, more significant bit.
                let nextFlag = newFlag >> 1
                
                // Recursively find the number of ways for the rest of the problem.
                let waysForRest = dfs(m - f, k - bitSet, i + 1, nextFlag)
                
                ans = (ans + perm * waysForRest) % Solution.MOD
                
                // Update the weight for the next iteration (for f+1).
                powX = (powX * x) % Solution.MOD
            }

            memo[key] = ans
            return ans
        }

        // Start the calculation from the initial state.
        return Int(dfs(m, k, 0, 0))
    }
}