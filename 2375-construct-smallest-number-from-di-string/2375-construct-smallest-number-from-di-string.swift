class Solution {
    func smallestNumber(_ pattern: String) -> String {
        var result = ""
        var decreasingStack = [Int]() // Stack to store numbers for decreasing sequences
        var currentNumber = 1

        // Iterate through the pattern string
        for char in pattern {
            if char == "D" {
                decreasingStack.append(currentNumber) // Push the current number for decreasing pattern
                currentNumber += 1
            } else { // char == "I"
                decreasingStack.append(currentNumber) // Push the current number for increasing pattern
                currentNumber += 1

                // Pop numbers from the stack to build the result (in reverse order for "I")
                while let last = decreasingStack.popLast() {
                    result.append(String(last))
                }
            }
        }

        decreasingStack.append(currentNumber) // Add the last number

        // Pop remaining numbers from the stack
        while let last = decreasingStack.popLast() {
            result.append(String(last))
        }

        return result
    }
}