// Time Complexity: O(N)
// - Converting the input string to an array of characters takes O(N) time, where N is the length of the string.
// - The loop runs approximately N/k times. Inside the loop, creating a substring from the character array and
//   potentially creating a padding string and concatenating them both take O(k) time in the worst case
//   (when k is large, or for each segment).
// - Since there are N/k segments, and each segment operation costs O(k), the total time for the loop is (N/k) * O(k) = O(N).
// - Appending to the result array is amortized O(1) due to `reserveCapacity`.
// - Therefore, the overall time complexity is O(N).

// Space Complexity: O(N)
// - Converting the input string to a `stringCharacters` array takes O(N) space.
// - The `resultSegments` array stores all the generated substrings. In total, these substrings
//   will contain N characters (including any added fill characters), leading to O(N) space.

class Solution {
    /// Divides a given string into segments of a specified length,
    /// padding the last segment if necessary with a fill character.
    ///
    /// - Parameters:
    ///   - inputString: The string to be divided.
    ///   - segmentLength: The desired length for each segment (k).
    ///   - fillCharacter: The character used to pad the last segment if it's shorter than `segmentLength`.
    /// - Returns: An array of strings, where each string is a segment of `segmentLength`.
    func divideString(_ inputString: String, _ segmentLength: Int, _ fillCharacter: Character) -> [String] {
        // Convert the input string into an array of characters for efficient indexing.
        let stringCharacters = Array(inputString)
        let totalCharacters = stringCharacters.count
        
        // Initialize an array to store the resulting string segments.
        var resultSegments = [String]()
        
        // Pre-allocate memory for the result array to optimize performance
        // by reducing the number of reallocations as segments are added.
        // The formula (totalCharacters + segmentLength - 1) / segmentLength calculates the ceiling division.
        resultSegments.reserveCapacity((totalCharacters + segmentLength - 1) / segmentLength)
        
        // Iterate through the characters array, starting a new segment every 'segmentLength' characters.
        for segmentStartIndex in stride(from: 0, to: totalCharacters, by: segmentLength) {
            // Determine the ending index for the current segment.
            // It's either 'segmentStartIndex + segmentLength' or the end of the string, whichever comes first,
            // to handle the potentially shorter last segment.
            let segmentEndIndex = min(segmentStartIndex + segmentLength, totalCharacters)
            
            // Extract the current segment as a substring.
            let currentSegment = String(stringCharacters[segmentStartIndex..<segmentEndIndex])
            
            // Check if the current segment is shorter than the desired segmentLength.
            // This will only be true for the very last segment if totalCharacters is not a multiple of segmentLength.
            if currentSegment.count < segmentLength {
                // Calculate the number of characters needed for padding.
                let charactersToPad = segmentLength - currentSegment.count
                // Create a padding string by repeating the fillCharacter.
                let paddingString = String(repeating: fillCharacter, count: charactersToPad)
                // Append the current segment concatenated with the padding.
                resultSegments.append(currentSegment + paddingString)
            } else {
                // If the segment is already of the desired length, append it directly.
                resultSegments.append(currentSegment)
            }
        }
        
        // Return the array containing all the divided and potentially padded string segments.
        return resultSegments
    }
}