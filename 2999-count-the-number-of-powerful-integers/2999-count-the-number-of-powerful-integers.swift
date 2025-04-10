class Solution {
    func numberOfPowerfulInt(_ start: Int, _ finish: Int, _ limit: Int, _ s: String) -> Int {
        // Helper function to count powerful integers up to a given value
        func countPowerfulIntegers(upTo value: Int) -> Int {
            let valueString = String(value) // Convert the value to a string
            let suffixLength = s.count // Length of the required suffix
            let prefixLength = valueString.count - suffixLength // Length of the prefix portion of the value

            // If the value string is shorter than the required suffix, no such integers exist
            if prefixLength < 0 { return 0 }

            // dp[i][0]: Count of powerful integers with prefix of length i, less than the given value
            // dp[i][1]: Count of powerful integers with prefix of length i, equal to the given value (so far)
            var dp = Array(repeating: [0, 0], count: prefixLength+1)
            dp[prefixLength][0] = 1 // Base case: empty prefix is always less
            let suffixStartIndex = valueString.index(valueString.startIndex, offsetBy: prefixLength)
            let suffixFromValue = String(valueString[suffixStartIndex...]) // The suffix portion of the value

            // Base case: If the suffix of the value is greater than or equal to s, then the value itself is a powerful integer
            dp[prefixLength][1] = suffixFromValue >= s ? 1 : 0

            // Iterate backwards through the prefix digits, building up the dp table
            for i in stride(from: prefixLength-1, through: 0, by: -1) {
                let digitChar = valueString[valueString.index(valueString.startIndex, offsetBy: i)]
                let digit = digitChar.wholeNumberValue ?? 0 // Convert the digit character to an integer

                // Count of powerful integers with prefix of length i, less than the given value
                dp[i][0] = (limit+1) * dp[i+1][0] // Can choose any digit from 0 to limit

                // Count of powerful integers with prefix of length i, equal to the given value (so far)
                if digit <= limit {
                    dp[i][1] = digit * dp[i+1][0] + dp[i+1][1] // Can choose digits from 0 to digit
                } else {
                    dp[i][1] = (limit+1) * dp[i+1][0] // Can choose any digit from 0 to limit
                }
            }

            return dp[0][1] // The final result is stored in dp[0][1]
        }

        return countPowerfulIntegers(upTo: finish) - countPowerfulIntegers(upTo: start-1)
    }
}