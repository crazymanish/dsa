class Solution {
    /**
     Problem Summary:
     Processes a string using special operations:
     - "*" removes the last character from the current result if possible.
     - "#" duplicates the current result.
     - "%" reverses the current result.
     - Any lowercase letter is appended to the result.

     Strategy:
     Iterate through each character and apply the operation directly to the result string.

     Time Complexity:
     O(n * m), where `n` is the length of `s` and `m` is the current result length.

     Space Complexity:
     O(m), where `m` is the final length of the processed string.
     */
    func processStr(_ s: String) -> String {
        var result = ""

        for character in s {
            switch character {
            case "*":
                // Remove the last character only when one exists.
                if !result.isEmpty {
                    result.removeLast()
                }

            case "#":
                // Duplicate the current result.
                result += result

            case "%":
                // Reverse the current result.
                result = String(result.reversed())

            default:
                // Append normal characters.
                result.append(character)
            }
        }

        return result
    }
}