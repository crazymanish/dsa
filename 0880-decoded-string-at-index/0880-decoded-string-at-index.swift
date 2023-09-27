class Solution {
    func decodeAtIndex(_ s: String, _ k: Int) -> String {
        // Initialize the variable to keep track of the total size of the decoded string.
        var size = 0

        // Step 1: Calculate the total size of the decoded string.
        for character in s {
            if character.isLetter {
                // If the character is a letter, increment the size by 1.
                size += 1
            } else if character.isNumber {
                // If the character is a digit, convert it to an integer and multiply the size by the digit.
                if let num = Int(String(character)) {
                    size *= num
                }
            }
        }

        // Initialize the variable to keep track of the remaining k value.
        var k = k

        // Step 2: Iterate through the characters of s in reverse order.
        for character in s.reversed() {
            // Calculate k modulo size to find the effective position in the decoded string.
            k %= size

            // If k becomes 0 and the character is a letter, return it as the result.
            if k == 0 && character.isLetter {
                return String(character)
            }

            // If the character is a letter, decrement the size by 1.
            if character.isLetter {
                size -= 1
            } else if character.isNumber {
                // If the character is a digit, convert it to an integer and divide the size by the digit.
                if let num = Int(String(character)) {
                    size /= num
                }
            }
        }

        // If k is not found in the reversed string, return an empty string (shouldn't reach this point).
        return ""
    }
}