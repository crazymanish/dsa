class Solution {

    /**
     Problem Summary:
     Find the k-th smallest positive integer that is divisible by at least one
     value in `coins`.

     Strategy:
     1. Remove redundant coins:
        - If a coin is divisible by a smaller coin, it contributes no new numbers.
     2. Use inclusion-exclusion to count how many integers <= `value`
        are divisible by at least one remaining coin.
     3. Precompute the LCM for every non-empty subset of coins.
        - Odd-sized subsets are added.
        - Even-sized subsets are subtracted.
     4. Binary search for the smallest value whose divisible-number count
        is at least `k`.

     Time Complexity:
     - Removing redundant coins: O(n²)
     - Precomputing subsets: O(2^m * m), where m is the remaining coin count
     - Binary search: O(2^m * log(k * minCoin))

     Space Complexity:
     - O(2^m) for the inclusion-exclusion subset values.
     */
    func findKthSmallest(_ coins: [Int], _ k: Int) -> Int {

        func gcd(_ first: Int, _ second: Int) -> Int {
            if second == 0 {
                return first
            }
            return gcd(second, first % second)
        }

        func lcm(_ first: Int, _ second: Int) -> Int {
            first / gcd(first, second) * second
        }

        func bitCount(_ value: Int) -> Int {
            var value = value
            var count = 0

            while value > 0 {
                if value & 1 == 1 {
                    count += 1
                }

                value >>= 1
            }

            return count
        }

        // Sort first so any divisor of a coin must appear before it.
        let sortedCoins = coins.sorted()

        var filteredCoins: [Int] = []

        // A coin is redundant when it is divisible by any smaller coin
        // already retained.
        for coin in sortedCoins {
            var isRedundant = false

            for existingCoin in filteredCoins {
                if coin % existingCoin == 0 {
                    isRedundant = true
                    break
                }
            }

            if !isRedundant {
                filteredCoins.append(coin)
            }
        }

        // If only one useful coin remains, every valid number is simply
        // a multiple of that coin.
        guard filteredCoins.count > 1 else {
            return filteredCoins[0] * k
        }

        let coinCount = filteredCoins.count
        let subsetCount = (1 << coinCount) - 1

        // inclusionExclusionLCM[mask]:
        //   positive LCM for odd-sized subsets
        //   negative LCM for even-sized subsets
        //
        // This lets countDivisibleNumbers() perform inclusion-exclusion
        // directly using division.
        var inclusionExclusionLCM = Array(
            repeating: 0,
            count: subsetCount + 1
        )

        for subsetMask in 1...subsetCount {
            var subsetLCM = 1

            for (coinIndex, coin) in filteredCoins.enumerated() {
                if subsetMask & (1 << coinIndex) != 0 {
                    subsetLCM = lcm(subsetLCM, coin)
                }
            }

            inclusionExclusionLCM[subsetMask] =
                bitCount(subsetMask) & 1 == 1
                ? subsetLCM
                : -subsetLCM
        }

        // Counts integers in 1...value that are divisible by at least
        // one coin using the inclusion-exclusion principle.
        func countDivisibleNumbers(upTo value: Int) -> Int {
            var count = 0

            for subsetMask in 1...subsetCount {
                count += value / inclusionExclusionLCM[subsetMask]
            }

            return count
        }

        // Binary-search invariant:
        // The answer lies inside [left, right].
        //
        // minCoin * k is always a valid upper bound because it already
        // contains at least k multiples of the smallest coin.
        var left = k + 1
        var right = filteredCoins[0] * k

        while left < right {
            let middle = left + (right - left) / 2

            if countDivisibleNumbers(upTo: middle) < k {
                left = middle + 1
            } else {
                right = middle
            }
        }

        return left
    }
}