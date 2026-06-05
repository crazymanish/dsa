class Solution {
    /**
     Problem Summary:
     Count the total waviness of every number in the inclusive range `[num1, num2]`.

     A digit is "wavy" when it is strictly greater than both neighboring digits
     or strictly smaller than both neighboring digits.

     Strategy:
     Use digit DP.

     Count total waviness from `0...num`, then subtract:

     `totalWaviness(num1...num2) = count(upTo: num2) - count(upTo: num1 - 1)`

     The DP builds numbers digit by digit and tracks the last two real digits.
     Once a third digit is added, we can decide whether the middle digit is wavy.

     Time Complexity:
     O(D * 11 * 11 * 10), where D is the number of digits.

     Space Complexity:
     O(D * 11 * 11)
     */
    func totalWaviness(_ num1: Int, _ num2: Int) -> Int {
        countTotalWaviness(upTo: num2) - countTotalWaviness(upTo: num1 - 1)
    }

    private func countTotalWaviness(upTo number: Int) -> Int {
        guard number > 0 else { return 0 }

        let digits = digitsOf(number)
        var memo = [State: DPResult]()

        func dfs(at index: Int, isBounded: Bool, hasStartedNumber: Bool, secondLastDigit: Int, lastDigit: Int) -> DPResult {
            guard index < digits.count else {
                return DPResult(count: 1, waviness: 0)
            }

            let state = State(
                index: index,
                secondLastDigit: secondLastDigit,
                lastDigit: lastDigit
            )

            // Only unbounded states can be reused safely.
            if !isBounded, let cachedResult = memo[state] {
                return cachedResult
            }

            let maxDigit = isBounded ? digits[index] : 9
            var totalResult = DPResult(count: 0, waviness: 0)

            for currentDigit in 0...maxDigit {
                let nextIsBounded = isBounded && currentDigit == maxDigit

                // Ignore leading zeroes because they are not part of the number.
                if !hasStartedNumber && currentDigit == 0 {
                    let childResult = dfs(
                        at: index + 1,
                        isBounded: nextIsBounded,
                        hasStartedNumber: false,
                        secondLastDigit: -1,
                        lastDigit: -1
                    )

                    totalResult.add(childResult)
                    continue
                }

                let nextState = updatedDigitState(
                    hasStartedNumber: hasStartedNumber,
                    secondLastDigit: secondLastDigit,
                    lastDigit: lastDigit,
                    currentDigit: currentDigit
                )

                let childResult = dfs(
                    at: index + 1,
                    isBounded: nextIsBounded,
                    hasStartedNumber: true,
                    secondLastDigit: nextState.secondLastDigit,
                    lastDigit: nextState.lastDigit
                )

                totalResult.count += childResult.count
                totalResult.waviness += childResult.waviness + childResult.count * nextState.extraWaviness
            }

            if !isBounded {
                memo[state] = totalResult
            }

            return totalResult
        }

        return dfs(at: 0, isBounded: true, hasStartedNumber: false, secondLastDigit: -1, lastDigit: -1).waviness
    }

    private func updatedDigitState(hasStartedNumber: Bool, secondLastDigit: Int, lastDigit: Int, currentDigit: Int) -> (secondLastDigit: Int, lastDigit: Int, extraWaviness: Int) {
        if !hasStartedNumber {
            // First real digit.
            return (-1, currentDigit, 0)
        }

        if secondLastDigit == -1 {
            // Second real digit. Still not enough digits to form a wave.
            return (lastDigit, currentDigit, 0)
        }

        // Now we can check whether `lastDigit` is a peak or valley.
        let extraWaviness = isWavy(left: secondLastDigit, middle: lastDigit, right: currentDigit) ? 1 : 0

        return (lastDigit, currentDigit, extraWaviness)
    }

    private func isWavy(left: Int, middle: Int, right: Int) -> Bool {
        let isPeak = middle > left && middle > right
        let isValley = middle < left && middle < right

        return isPeak || isValley
    }

    private func digitsOf(_ number: Int) -> [Int] {
        var number = number
        var digits = [Int]()

        while number > 0 {
            digits.append(number % 10)
            number /= 10
        }

        return digits.reversed()
    }
}

private struct State: Hashable {
    let index: Int
    let secondLastDigit: Int
    let lastDigit: Int
}

private struct DPResult {
    var count: Int
    var waviness: Int

    mutating func add(_ other: DPResult) {
        count += other.count
        waviness += other.waviness
    }
}