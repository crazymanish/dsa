class Solution {
    func closestPrimes(_ left: Int, _ right: Int) -> [Int] {
        var previousPrime = -1 // Store the previous prime number found
        var minDiff = Int.max // Initialize the minimum difference to the maximum possible value
        var result = [-1, -1] // Initialize the result array to [-1, -1]

        // Nested function to check if a number is prime (optimized)
        func isPrime(_ num: Int) -> Bool {
            if num <= 1 { return false }
            if num <= 3 { return true }
            if num % 2 == 0 || num % 3 == 0 { return false }
            var i = 5
            while i * i <= num {
                if num % i == 0 || num % (i + 2) == 0 { return false }
                i += 6
            }
            return true
        }

        // Iterate through the range of numbers
        for currentNumber in left...right {
            if isPrime(currentNumber) { // Check if the current number is prime
                if previousPrime != -1 && currentNumber - previousPrime < minDiff {
                    // If a previous prime was found and the difference is smaller than minDiff
                    minDiff = currentNumber - previousPrime // Update minDiff
                    result = [previousPrime, currentNumber] // Update the result array
                }
                previousPrime = currentNumber // Update previousPrime to the current prime number
            }
        }

        return result
    }
}