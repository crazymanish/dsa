/**
 Problem Summary
 ----------------
 We need to count the number of binary arrays that contain exactly `zero` zeros
 and `one` ones such that no more than `limit` identical numbers appear consecutively.

 A "stable array" means:
 - At most `limit` consecutive `0`s
 - At most `limit` consecutive `1`s

 The result must be returned modulo 1_000_000_007.

 Strategy
 --------
 Dynamic Programming.

 Let:
 dp[i][j][0] = number of valid arrays using:
               - i zeros
               - j ones
               - ending with 0

 dp[i][j][1] = number of valid arrays using:
               - i zeros
               - j ones
               - ending with 1

 Transition:
 ----------
If we place a `0` at the end:
    dp[i][j][0] = dp[i-1][j][0] + dp[i-1][j][1]

However this may create more than `limit` consecutive zeros.
If the last `limit+1` elements become zeros we must subtract those cases.

Those invalid cases are the arrays that previously ended with `1` and
already had `limit+1` zeros appended.

So we subtract:
    dp[i - limit - 1][j][1]

Similarly for ones.

To keep values positive we add MOD before applying modulo.

 Time Complexity
 ----------------
 O(zero * one)

 Space Complexity
 ----------------
 O(zero * one)
*/

class Solution {

    func numberOfStableArrays(_ zero: Int, _ one: Int, _ limit: Int) -> Int {

        let mod = 1_000_000_007

        // dp[i][j][k]
        // i = zeros used
        // j = ones used
        // k = ending digit (0 or 1)
        var dp = Array(
            repeating: Array(repeating: [0, 0], count: one + 1),
            count: zero + 1
        )

        // Base cases:
        // Arrays consisting of only zeros
        for count in 1...min(zero, limit) {
            dp[count][0][0] = 1
        }

        // Arrays consisting of only ones
        for count in 1...min(one, limit) {
            dp[0][count][1] = 1
        }

        // Helper to subtract invalid states that exceed `limit` zeros
        func subtractZeroOverflow(_ i: Int, _ j: Int) -> Int {
            if i - limit - 1 >= 0 {
                return dp[i - limit - 1][j][1]
            }
            return 0
        }

        // Helper to subtract invalid states that exceed `limit` ones
        func subtractOneOverflow(_ i: Int, _ j: Int) -> Int {
            if j - limit - 1 >= 0 {
                return dp[i][j - limit - 1][0]
            }
            return 0
        }

        // Fill DP table
        for zerosUsed in 1...zero {
            for onesUsed in 1...one {

                // Case 1: append 0
                dp[zerosUsed][onesUsed][0] =
                    (
                        dp[zerosUsed - 1][onesUsed][0] +
                        dp[zerosUsed - 1][onesUsed][1] -
                        subtractZeroOverflow(zerosUsed, onesUsed) +
                        mod
                    ) % mod

                // Case 2: append 1
                dp[zerosUsed][onesUsed][1] =
                    (
                        dp[zerosUsed][onesUsed - 1][0] +
                        dp[zerosUsed][onesUsed - 1][1] -
                        subtractOneOverflow(zerosUsed, onesUsed) +
                        mod
                    ) % mod
            }
        }

        // Final result: arrays ending with 0 or 1
        return (dp[zero][one][0] + dp[zero][one][1]) % mod
    }
}