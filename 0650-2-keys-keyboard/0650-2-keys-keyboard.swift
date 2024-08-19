class Solution {
    func minSteps(_ n: Int) -> Int {
        // This variable will store the minimum number of operations needed
        var steps = 0
        // Start with the smallest possible divisor, which is 2
        var divisor = 2
        var number = n

        // We will divide the number by the smallest possible divisor (starting from 2)
        // until the number becomes 1
        while number > 1 {
            // If the current number is divisible by the divisor
            while number % divisor == 0 {
                // Add the divisor to the steps count
                steps += divisor
                // Divide the number by the divisor
                number /= divisor
            }
            // Move to the next divisor
            divisor += 1
        }

        return steps
    }
}