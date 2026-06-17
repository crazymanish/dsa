class Solution {
    /**
     Problem Summary:
     Process a string of operations and return the character at index `k`
     in the final generated string without actually building that string.

     Operations:
     - Letter: append the character
     - "*": remove the last character if the result is not empty
     - "#": duplicate the current result
     - "%": reverse the current result

     Strategy:
     First, scan the operations from left to right and store the string length
     after each operation.
     
     Then, scan backward and undo the effect of each operation on index `k`.
     This lets us find which original appended character produced the final
     character at index `k`.

     Time Complexity: O(n)
     Space Complexity: O(n)
     */
    func processStr(_ s: String, _ k: Int) -> Character {
        let operations = Array(s)
        var lengths = Array(repeating: 0, count: operations.count + 1)

        // Build length history without constructing the actual result string.
        for index in operations.indices {
            let previousLength = lengths[index]

            switch operations[index] {
            case "*":
                lengths[index + 1] = previousLength > 0 ? previousLength - 1 : 0

            case "#":
                lengths[index + 1] = previousLength * 2

            case "%":
                lengths[index + 1] = previousLength

            default:
                lengths[index + 1] = previousLength + 1
            }
        }

        var targetIndex = k

        // Defensive fallback if k is outside the final processed string.
        guard targetIndex >= 0, targetIndex < lengths[operations.count] else {
            return "."
        }

        // Walk backward and translate targetIndex to its position before each operation.
        for index in stride(from: operations.count - 1, through: 0, by: -1) {
            let operation = operations[index]
            let previousLength = lengths[index]

            switch operation {
            case "*":
                // Deleting the last character does not affect any surviving index.
                continue

            case "#":
                // The second copy maps back to the same index in the first copy.
                if previousLength > 0 {
                    targetIndex %= previousLength
                }

            case "%":
                // Reversal mirrors the index around the center.
                if previousLength > 0 {
                    targetIndex = previousLength - 1 - targetIndex
                }

            default:
                // This character was appended at index `previousLength`.
                if targetIndex == previousLength {
                    return operation
                }
            }
        }

        return "."
    }
}