class Solution {
    func punishmentNumber(_ n: Int) -> Int {
        // Helper function to extract digits from an integer
        func digits(_ x: Int) -> [Int] {
            var num = x // Create a mutable copy
            var digitArray = [Int]()
            while num > 0 {
                digitArray.append(num % 10) // Extract last digit
                num /= 10 // Remove last digit
            }
            return digitArray.reversed() // Reverse to get correct order
        }

        // Recursive DFS function to check if a number can be partitioned
        func canPartition(index: Int = 0, currentSum: Int = 0, target: Int, digitArray: [Int]) -> Bool {
            // Base case: If we've processed all digits and the current sum equals the target, it's a valid partition
            if index == digitArray.count && currentSum == target {
                return true
            }

            // Explore all possible partitions starting from the current index
            var result = false // Initialize result for this branch
            var tempNumber = 0 // Temporary number to build substrings
            for i in index..<digitArray.count {
                tempNumber = tempNumber * 10 + digitArray[i] // Build the current substring number
                // Recursive call: Explore the remaining digits with the updated sum
                result = result || canPartition(index: i + 1, currentSum: currentSum + tempNumber, target: target, digitArray: digitArray)
                if result { // Optimization: If a valid partition is found, no need to explore further in this branch
                    return true
                }
            }
            return result // Return the result for this branch
        }

        var punishmentSum = 0

        for i in 1...n {
            let product = i * i // Calculate the square
            let digitArray = digits(product) // Extract digits from the square

            if canPartition(target: i, digitArray: digitArray) { // Check if it's a punishment number
                punishmentSum += product // Add the square to the punishment sum
            }
        }

        return punishmentSum // Return the total punishment sum
    }
}