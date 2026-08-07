/**
 Problem Summary:
 Find the smallest number greater than or equal to `num` whose digits'
 product is divisible by `t`.

 Strategy:
 1. Verify that `t` can be formed using digits 2...9.
 2. Track the remaining factors of `t` after processing each prefix.
 3. If the original number is insufficient, modify digits from right to left.
 4. Fill the suffix with the smallest digits that complete the factorization.

 Time Complexity:
 O(n * 9), where n is the number of digits in `num`.

 Space Complexity:
 O(n).
 */
class Solution {
    func smallestNumber(_ num: String, _ t: Int) -> String {
        let digits = Array(num.utf8)
        let digitCount = digits.count

        // If t contains any prime factor greater than 7, no digit product can divide it.
        var remainingTarget = t

        for digit in stride(from: 9, through: 2, by: -1) {
            while remainingTarget % digit == 0 {
                remainingTarget /= digit
            }
        }

        guard remainingTarget == 1 else {
            return "-1"
        }

        // remainingFactor[i] stores the part of t not covered by the first i digits.
        var remainingFactor = Array(repeating: t, count: digitCount + 1)
        var modificationIndex = digitCount - 1

        var resultDigits = digits

        for index in 0..<digitCount {
            // A zero cannot contribute to the product. We can only modify
            // the number from the first zero onward.
            if resultDigits[index] == 48 {
                modificationIndex = index
                break
            }

            let digit = Int(resultDigits[index] - 48)
            remainingFactor[index + 1] = divideByGCD(remainingFactor[index], digit)
        }

        // The original number already satisfies the requirement.
        if remainingFactor[digitCount] == 1 {
            return num
        }

        // Try increasing the rightmost possible digit first.
        for index in stride(from: modificationIndex, through: 0, by: -1) {
            while resultDigits[index] < 57 {
                resultDigits[index] += 1

                let changedDigit = Int(resultDigits[index] - 48)
                var suffixTarget = divideByGCD(
                    remainingFactor[index],
                    changedDigit
                )

                // Complete the suffix using the largest possible digits first.
                // This minimizes the first changed position while keeping
                // the entire number as small as possible.
                var fillDigit = 9

                for suffixIndex in stride(
                    from: digitCount - 1,
                    through: index + 1,
                    by: -1
                ) {
                    while suffixTarget % fillDigit != 0 {
                        fillDigit -= 1
                    }

                    suffixTarget /= fillDigit
                    resultDigits[suffixIndex] = UInt8(fillDigit + 48)
                }

                if suffixTarget == 1 {
                    return String(bytes: resultDigits, encoding: .utf8)!
                }
            }
        }

        // If no number with the same length works, construct the smallest
        // valid number with one additional digit.
        var requiredDigits: [UInt8] = []
        var fallbackTarget = t

        for digit in stride(from: 9, through: 2, by: -1) {
            while fallbackTarget % digit == 0 {
                requiredDigits.append(UInt8(digit + 48))
                fallbackTarget /= digit
            }
        }

        let minimumLength = max(digitCount + 1, requiredDigits.count)
        requiredDigits.append(
            contentsOf: repeatElement(49, count: minimumLength - requiredDigits.count)
        )

        return String(bytes: requiredDigits.reversed(), encoding: .utf8)!
    }

    private func divideByGCD(_ value: Int, _ digit: Int) -> Int {
        var first = value
        var second = digit

        while second != 0 {
            let remainder = first % second
            first = second
            second = remainder
        }

        return value / first
    }
}