// Time Complexity: O(n), where 'n' is the number of characters in the input string.
// The code iterates through the string once to build the frequency map (O(n))
// and then iterates through the unique characters (O(k), where k <= n).
// Thus, the dominant factor is O(n).

// Space Complexity: O(k), where 'k' is the number of unique characters.
// In the worst-case scenario, the dictionary will store a key-value pair
// for each unique character in the string.
class Solution {
    /// Calculates the difference between the maximum frequency of a character appearing an odd number of times
    /// and the minimum frequency of a character appearing an even number of times.
    func maxDifference(_ inputString: String) -> Int {
        // A dictionary to store the frequency count of each character.
        var characterFrequencies: [Character: Int] = [:]

        // Populate the frequency map for each character in the string.
        for character in inputString {
            characterFrequencies[character, default: 0] += 1
        }
        
        // Initialize the maximum odd frequency to a value lower than any possible frequency.
        var maxOddFrequency = -1
        // Initialize the minimum even frequency to the largest possible integer value
        // to ensure any found even frequency will be smaller.
        var minEvenFrequency = Int.max
        
        // Iterate through the frequencies to find the max odd and min even values.
        for frequency in characterFrequencies.values {
            if frequency % 2 == 0 {
                // If the frequency is even, update the minimum even frequency.
                minEvenFrequency = min(minEvenFrequency, frequency)
            } else {
                // If the frequency is odd, update the maximum odd frequency.
                maxOddFrequency = max(maxOddFrequency, frequency)
            }
        }
        
        // Return the calculated difference.
        // If no odd-frequency characters are found, maxOddFrequency remains -1.
        // If no even-frequency characters are found, minEvenFrequency remains Int.max.
        return maxOddFrequency - minEvenFrequency
    }
}