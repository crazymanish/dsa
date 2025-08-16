// Time Complexity: O(D)
//   - D: The number of digits in `num`.
//   - Converting an integer to a string takes O(D) time.
//   - Creating a character array is O(D).
//   - `firstIndex(of:)` iterates through the array, taking up to O(D) time.
//   - Converting the character array back to an integer is O(D).
//
// Space Complexity: O(D)
//   - A new string and character array are created, requiring space proportional to the number of digits.
class Solution {
    func maximum69Number (_ num: Int) -> Int {
        // Convert the number to an array of characters for easy manipulation.
        var charArray = Array(String(num))
        
        // Find the index of the first occurrence of '6'.
        // The `firstIndex(of:)` method efficiently finds the leftmost '6'.
        if let indexOfFirstSix = charArray.firstIndex(of: "6") {
            // If a '6' is found, change it to a '9'.
            charArray[indexOfFirstSix] = "9"
        }

        // Convert the modified character array back to a string, then to an integer.
        // The force-unwrap `!` is safe because the string will always represent a valid number.
        return Int(String(charArray))!
    }
}