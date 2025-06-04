// Time Complexity: O(N * M)
//   - N: Length of the input `word`.
//   - M: The `targetSubstringLength`, which is `wordLength - numFriends + 1`.
//   - Converting `word` to `wordCharacters`: O(N).
//   - The main loop iterates `N` times (from `startIndex = 0` to `wordLength - 1`).
//   - Inside the loop:
//     - Substring creation `Array(wordCharacters[startIndex..<endIndexForCandidate])`: This takes O(L) where L is the length of the candidate substring. L is at most M. So, O(M).
//     - Lexicographical comparison `candidateSubstring.lexicographicallyPrecedes(lexicographicallyLargestSubstring!)`: This also takes O(L) or O(M) in the worst case.
//   - Therefore, the total time complexity is dominated by the loop: N iterations * O(M) work per iteration = O(N * M).
//   - In the worst case, if `numFriends = 1`, then `M = N`, leading to O(N^2).
//   - In the best case, if `numFriends = N`, then `M = 1`, leading to O(N).
//
// Space Complexity: O(N)
//   - `wordCharacters`: O(N) to store the characters of the word.
//   - `lexicographicallyLargestSubstring`: O(M) to store the characters of the result. Since M <= N, this is O(N).
//   - `candidateSubstring`: O(M) for the temporary candidate. This is O(N).
//   - Overall space complexity is O(N).

class Solution {
    func answerString(_ word: String, _ numFriends: Int) -> String {
        // If there's only one friend, that friend gets the entire word.
        if numFriends == 1 { return word }

        let wordLength = word.count
        
        // Calculate the target length for substrings we are interested in.
        // This length is derived from the word length and the number of friends.
        // It represents a potential length of a segment if the word were distributed.
        let targetSubstringLength = wordLength - numFriends + 1
        
        // If the target length is not positive (e.g., more friends than characters + 1),
        // it's impossible to form a valid substring according to this rule.
        guard targetSubstringLength > 0 else { return "" }
        
        let wordCharacters = Array(word)
        var lexicographicallyLargestSubstring: [Character]? = nil
        
        // Iterate through all possible starting positions in the word.
        for startIndex in 0..<wordLength {
            // Determine the number of characters remaining from the current startIndex.
            let remainingCharsInWord = wordLength - startIndex
            
            // Determine the actual length of the candidate substring.
            // It's the minimum of the targetSubstringLength and the remaining characters.
            // This means candidates can be shorter than targetSubstringLength if they are near the end of the word.
            let currentCandidateLength = min(targetSubstringLength, remainingCharsInWord)
            
            // If the calculated length for the candidate is not positive, we can stop.
            // (This check is mostly for safety, as targetSubstringLength > 0 and remainingCharsInWord will be >=1 in the loop unless wordLength is 0,
            // which should be handled by targetSubstringLength <= 0 guard if numFriends > 0).
            // However, min can result in 0 if targetSubstringLength is positive but remainingCharsInWord becomes 0 (which it won't due to loop bounds).
            // More practically, if currentCandidateLength becomes 0, it means no more valid substrings can be formed.
            // This can happen if wordLength < targetSubstringLength and startIndex makes remainingCharsInWord too small.
            // But given targetSubstringLength > 0, currentCandidateLength will be at least 1 if remainingCharsInWord >= 1.
            // The loop `0..<wordLength` ensures `remainingCharsInWord >= 1`.
            // So, `currentCandidateLength` will be at least `min(targetSubstringLength, 1)`, which is 1 if `targetSubstringLength >=1`.
            
            let endIndexForCandidate = startIndex + currentCandidateLength
            let candidateSubstring = Array(wordCharacters[startIndex..<endIndexForCandidate])
            
            // Compare the current candidate with the largest one found so far.
            // `candidate.lexicographicallyPrecedes(result)` means `candidate < result`.
            // So, `candidate.lexicographicallyPrecedes(result) == false` means `candidate >= result`.
            if lexicographicallyLargestSubstring == nil || 
               candidateSubstring.lexicographicallyPrecedes(lexicographicallyLargestSubstring!) == false {
                lexicographicallyLargestSubstring = candidateSubstring
            }
        }
        
        // If a result was found (which it should if targetSubstringLength > 0 and wordLength > 0), convert it to a String.
        // Otherwise, (e.g. if word was empty and targetSubstringLength was also non-positive, though guard should catch most), return empty.
        return lexicographicallyLargestSubstring != nil ? String(lexicographicallyLargestSubstring!) : ""
    }
}