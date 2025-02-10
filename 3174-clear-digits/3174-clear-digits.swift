class Solution {
    func clearDigits(_ s: String) -> String {
        var characters = Array(s) // Convert string to an array of characters

        while let firstDigitIndex = characters.firstIndex(where: { $0.isNumber }) { // Find the first digit directly
            characters.remove(at: firstDigitIndex) // Remove the digit

            // Find and remove the closest non-digit to the left (if any)
            var closestNonDigitIndex = firstDigitIndex - 1
            while closestNonDigitIndex >= 0 && characters[closestNonDigitIndex].isNumber {
                closestNonDigitIndex -= 1
            }

            if closestNonDigitIndex >= 0 {
                characters.remove(at: closestNonDigitIndex)
            }
        }

        return String(characters) // Convert back to string
    }
}