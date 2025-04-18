class Solution {
    func countAndSay(_ n: Int) -> String {
        // Nested helper function to describe and count the digits in a sequence
        func describeAndCount(_ digits: [Int]) -> [Int] {
            var counts: [(digit: Int, count: Int)] = digits.reduce(into: []) { (countedDigits, currentDigit) in
                // If the current digit is the same as the last one, increment the count
                if countedDigits.last?.digit == currentDigit {
                    countedDigits[countedDigits.endIndex - 1].count += 1
                } else {
                    // Otherwise, add a new (digit, count) pair to the array
                    countedDigits.append((currentDigit, 1))
                }
            }

            // Flatten the (count, digit) pairs into a single array
            return counts.flatMap { [$0.count, $0.digit] }
        }

        var sequence = [1] // Start with the initial sequence "1"

        // Generate the sequence from 2 to n
        for _ in 1..<n {
            sequence = describeAndCount(sequence) // Apply the describe-and-count process
        }

        // Convert the integer array to a string
        return sequence.map { String($0) }.joined()
    }
}