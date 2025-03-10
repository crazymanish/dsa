class Solution {
  func countOfSubstrings(_ word: String, _ k: Int, _ recurse:Bool = true) -> Int {
    // Dictionary to map vowels to indices for counter updates
    let vowelIndex = Dictionary(uniqueKeysWithValues: zip("aeiou", 1...))

    // Map each character to its corresponding counter index (0 for consonants, 1-5 for vowels)
    let indexForChar = word.map{vowelIndex[$0] ?? 0}

    // Counters: [consonants, a, e, i, o, u]
    var counters = [0, 0, 0, 0, 0, 0]

    // Minimum required counts for each element in counters
    let minVals  = [k, 1, 1, 1, 1, 1]

    var result = 0 // Initialize count of valid substrings
    var left = 0 // Left pointer of the sliding window

    // Iterate through characters using the right pointer of the sliding window
    for right in indexForChar.indices {
      // Increment the counter for the current character
      counters[indexForChar[right]] += 1

      // Check if the current window satisfies the criteria (all counters >= minimums)
      while zip(counters, minVals).allSatisfy(>=) {
        // If satisfied, all substrings from left to right are valid
        result += indexForChar.count - right

        // Decrement the counter for the leftmost character and move the left pointer
        counters[indexForChar[left]] -= 1
        left += 1
      }
    }

    // If recurse is true, subtract the count of substrings with at least k+1 consonants
    return result - (recurse ? countOfSubstrings(word, k + 1, false) : 0)
  }
}