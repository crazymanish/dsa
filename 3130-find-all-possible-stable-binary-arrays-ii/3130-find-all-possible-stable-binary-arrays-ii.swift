/**
 Problem Summary
 ----------------
 Count the number of binary arrays that contain exactly `zero` zeros and `one` ones
 such that no more than `limit` identical elements appear consecutively.

 A valid array:
 - Contains exactly `zero` number of 0's
 - Contains exactly `one` number of 1's
 - Never has more than `limit` consecutive 0's or 1's

 Return the count modulo 1_000_000_007.

 Strategy
 --------
 Dynamic Programming.

 Let:
 - dpEndWithZero[i][j] = number of valid arrays using `i` zeros and `j` ones
   where the last element is `0`.

 - dpEndWithOne[i][j] = number of valid arrays using `i` zeros and `j` ones
   where the last element is `1`.

 Transitions:

 To place a `0` at the end:
 - Previous state could end with `0` or `1`
 - But we must ensure we do not create more than `limit` consecutive zeros.

 dpEndWithZero[i][j] =
     dpEndWithZero[i-1][j] + dpEndWithOne[i-1][j]
     - dpEndWithOne[i-limit-1][j]   (remove invalid sequences)

 Similarly for placing `1`:

 dpEndWithOne[i][j] =
     dpEndWithOne[i][j-1] + dpEndWithZero[i][j-1]
     - dpEndWithZero[i][j-limit-1]

 The subtraction removes sequences where the run length exceeds `limit`.

 Base cases:
 - Arrays made only of zeros (up to `limit`)
 - Arrays made only of ones (up to `limit`)

 Time Complexity
 ---------------
 O(zero * one)

 Space Complexity
 ----------------
 O(zero * one)
 */

class Solution {

    private let mod = 1_000_000_007

    func numberOfStableArrays(_ zero: Int, _ one: Int, _ limit: Int) -> Int {

        // dpEndWithZero[i][j] → arrays with i zeros, j ones, ending with 0
        var dpEndWithZero = Array(
            repeating: Array(repeating: Int64(0), count: one + 1),
            count: zero + 1
        )

        // dpEndWithOne[i][j] → arrays with i zeros, j ones, ending with 1
        var dpEndWithOne = Array(
            repeating: Array(repeating: Int64(0), count: one + 1),
            count: zero + 1
        )

        // Base case: arrays consisting only of zeros
        if zero > 0 {
            for zeroCount in 1...min(zero, limit) {
                dpEndWithZero[zeroCount][0] = 1
            }
        }

        // Base case: arrays consisting only of ones
        if one > 0 {
            for oneCount in 1...min(one, limit) {
                dpEndWithOne[0][oneCount] = 1
            }
        }

        for zeroCount in 0...zero {
            for oneCount in 0...one {

                if zeroCount == 0 && oneCount == 0 {
                    continue
                }

                if zeroCount > 0 && oneCount > 0 {

                    // Place 0 at the end
                    dpEndWithZero[zeroCount][oneCount] =
                        (dpEndWithZero[zeroCount - 1][oneCount]
                        + dpEndWithOne[zeroCount - 1][oneCount]) % Int64(mod)

                    // Remove sequences where zeros exceed the allowed limit
                    if zeroCount - limit - 1 >= 0 {
                        dpEndWithZero[zeroCount][oneCount] =
                            (dpEndWithZero[zeroCount][oneCount]
                            - dpEndWithOne[zeroCount - limit - 1][oneCount]
                            + Int64(mod)) % Int64(mod)
                    }

                    // Place 1 at the end
                    dpEndWithOne[zeroCount][oneCount] =
                        (dpEndWithOne[zeroCount][oneCount - 1]
                        + dpEndWithZero[zeroCount][oneCount - 1]) % Int64(mod)

                    // Remove sequences where ones exceed the allowed limit
                    if oneCount - limit - 1 >= 0 {
                        dpEndWithOne[zeroCount][oneCount] =
                            (dpEndWithOne[zeroCount][oneCount]
                            - dpEndWithZero[zeroCount][oneCount - limit - 1]
                            + Int64(mod)) % Int64(mod)
                    }
                }
            }
        }

        // Result = arrays ending with 0 + arrays ending with 1
        return Int((dpEndWithZero[zero][one] + dpEndWithOne[zero][one]) % Int64(mod))
    }
}