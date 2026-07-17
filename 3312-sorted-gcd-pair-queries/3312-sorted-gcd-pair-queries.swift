/**
 Problem Summary:
 Given an array of numbers, answer each query for the GCD value at the queried
 zero-based position among all unordered pairs, sorted by their GCD.

 Strategy:
 1. Count the frequency of every value.
 2. For each possible divisor, count how many numbers are divisible by it.
 3. Process GCD values from largest to smallest to calculate pairs whose GCD is
    exactly that value, subtracting pairs already assigned to larger multiples.
 4. Build a prefix sum where prefix[g] is the number of pairs with GCD <= g.
 5. Use binary search to find the GCD at each queried pair index.

 Time Complexity:
 O(maxValue * log(maxValue) + queries.count * log(maxValue))

 Space Complexity:
 O(maxValue)
 */
class Solution {
    func gcdValues(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let maximumValue = nums.max()!

        // Count occurrences of every number.
        var frequency = Array(repeating: 0, count: maximumValue + 1)
        for number in nums {
            frequency[number] += 1
        }

        // divisibleCount[divisor] = count of numbers divisible by divisor.
        var divisibleCount = Array(repeating: 0, count: maximumValue + 1)

        for divisor in 1...maximumValue {
            var multiple = divisor

            while multiple <= maximumValue {
                divisibleCount[divisor] += frequency[multiple]
                multiple += divisor
            }
        }

        // exactPairCount[gcd] = number of pairs whose GCD is exactly gcd.
        var exactPairCount = Array(repeating: Int64(0), count: maximumValue + 1)

        for gcd in stride(from: maximumValue, through: 1, by: -1) {
            let divisibleNumbers = Int64(divisibleCount[gcd])

            // All pairs formed from numbers divisible by gcd.
            var pairCount = divisibleNumbers * (divisibleNumbers - 1) / 2

            // Remove pairs whose actual GCD is a larger multiple of gcd.
            var multiple = gcd * 2
            while multiple <= maximumValue {
                pairCount -= exactPairCount[multiple]
                multiple += gcd
            }

            exactPairCount[gcd] = pairCount
        }

        // prefixPairCount[gcd] = number of pairs with GCD less than or equal to gcd.
        var prefixPairCount = Array(repeating: Int64(0), count: maximumValue + 1)

        for gcd in 1...maximumValue {
            prefixPairCount[gcd] = prefixPairCount[gcd - 1] + exactPairCount[gcd]
        }

        var results = [Int]()
        results.reserveCapacity(queries.count)

        for query in queries {
            // Queries are zero-based pair indices.
            let targetPairPosition = Int64(query + 1)

            // Find the first GCD whose prefix count reaches this pair position.
            var left = 1
            var right = maximumValue

            while left < right {
                let middle = left + (right - left) / 2

                if prefixPairCount[middle] >= targetPairPosition {
                    right = middle
                } else {
                    left = middle + 1
                }
            }

            results.append(left)
        }

        return results
    }
}