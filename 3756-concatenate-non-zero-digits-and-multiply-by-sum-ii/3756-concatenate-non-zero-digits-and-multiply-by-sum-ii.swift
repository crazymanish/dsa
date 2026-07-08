class Solution {
    /**
     Problem Summary:
     For each query `[left, right]`, take the substring `s[left...right]`,
     remove all zero digits, form the remaining number, multiply it by the
     sum of those remaining digits, and return the result modulo `1_000_000_007`.

     Strategy:
     - Build prefix data for non-zero digits:
       - `prefixNumber`: number formed by non-zero digits so far
       - `prefixDigitSum`: sum of non-zero digits so far
       - `prefixNonZeroCount`: count of non-zero digits so far
       - `powerOfTen`: powers of 10 for removing prefix contribution
     - For each query, extract:
       - the compacted number inside the range
       - the digit sum inside the range
     - Return `number * digitSum % MOD`.

     Time Complexity:
     O(n + q), where n is the length of `s` and q is the number of queries.

     Space Complexity:
     O(n), for prefix arrays.
     */
    func sumAndMultiply(_ s: String, _ queries: [[Int]]) -> [Int] {
        let modulo = 1_000_000_007
        let digits = s.compactMap(\.wholeNumberValue)
        let digitCount = digits.count

        var prefixNumber = Array(repeating: 0, count: digitCount + 1)
        var prefixDigitSum = Array(repeating: 0, count: digitCount + 1)
        var prefixNonZeroCount = Array(repeating: 0, count: digitCount + 1)
        var powerOfTen = Array(repeating: 1, count: digitCount + 1)

        for index in 0..<digitCount {
            let digit = digits[index]

            // Carry forward prefix values by default.
            prefixNumber[index + 1] = prefixNumber[index]
            prefixDigitSum[index + 1] = prefixDigitSum[index]
            prefixNonZeroCount[index + 1] = prefixNonZeroCount[index]

            // Precompute powers of 10 for removing the left prefix contribution.
            powerOfTen[index + 1] = (powerOfTen[index] * 10) % modulo

            // Only non-zero digits are used to build the compacted number.
            if digit != 0 {
                prefixNumber[index + 1] = (prefixNumber[index] * 10 + digit) % modulo
                prefixDigitSum[index + 1] += digit
                prefixNonZeroCount[index + 1] += 1
            }
        }

        var results: [Int] = []

        for query in queries {
            let left = query[0]
            let right = query[1]

            let nonZeroDigitsInRange = prefixNonZeroCount[right + 1] - prefixNonZeroCount[left]

            // Remove the compacted number formed before `left`.
            let leftPrefixContribution = prefixNumber[left] * powerOfTen[nonZeroDigitsInRange] % modulo
            let compactedNumber = (prefixNumber[right + 1] - leftPrefixContribution + modulo) % modulo

            // Sum of all non-zero digits in the query range.
            let digitSum = prefixDigitSum[right + 1] - prefixDigitSum[left]

            results.append(compactedNumber * digitSum % modulo)
        }

        return results
    }
}