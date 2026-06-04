class Solution {
    /**
     Problem Summary:
     Given two integers `num1` and `num2`, calculate the total "waviness"
     of all numbers in the inclusive range `[num1, num2]`.

     A digit contributes to waviness if it is strictly greater than both
     neighboring digits or strictly smaller than both neighboring digits.

     Strategy:
     - Numbers with fewer than 3 digits cannot have waviness.
     - For each number in the range, inspect every middle digit.
     - Compare each middle digit with its left and right neighbors.
     - Count it if it forms a local peak or local valley.

     Time Complexity:
     O((num2 - num1 + 1) * d), where `d` is the number of digits.

     Space Complexity:
     O(1), since only a few integer variables are used.
     */
    func totalWaviness(_ num1: Int, _ num2: Int) -> Int {
        guard num2 >= 100 else {
            return 0
        }

        var totalWaviness = 0

        for number in num1...num2 {
            guard number >= 100 else {
                continue
            }

            totalWaviness += waviness(of: number)
        }

        return totalWaviness
    }

    private func waviness(of number: Int) -> Int {
        var currentNumber = number

        // The digit on the right side of the current middle digit.
        var rightDigit = currentNumber % 10
        currentNumber /= 10

        var wavinessCount = 0

        // Continue while there is still a left neighbor for the middle digit.
        while currentNumber >= 10 {
            let middleDigit = currentNumber % 10
            let leftDigit = (currentNumber / 10) % 10

            let isPeak = middleDigit > leftDigit && middleDigit > rightDigit
            let isValley = middleDigit < leftDigit && middleDigit < rightDigit

            if isPeak || isValley {
                wavinessCount += 1
            }

            // Move one digit to the left.
            rightDigit = middleDigit
            currentNumber /= 10
        }

        return wavinessCount
    }
}