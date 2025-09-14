// Time Complexity: O(W*L + Q*L)
//   - W: The number of words in the `wordlist`.
//   - Q: The number of queries.
//   - L: The maximum length of a word or query.
//   - Pre-computation: Building each of the three lookup tables requires iterating through
//     `W` words and performing operations (hashing, lowercasing, devoweling) that take
//     O(L) time per word. This phase is O(W * L).
//   - Query Processing: For each of the `Q` queries, we perform up to three lookups. Each
//     lookup involves processing the query string (hashing, lowercasing, etc.), which takes
//     O(L) time. This phase is O(Q * L).
//
// Space Complexity: O(W*L)
//   - The three lookup data structures (`exactMatches`, `caseInsensitiveMatches`, `vowelErrorMatches`)
//     store data derived from the initial `wordlist`. In the worst case, the space required is
//     proportional to the total number of characters in the `wordlist`.
class Solution {
    /**
     * Checks a list of queries against a wordlist according to a specific set of spelling rules.
     *
     * The strategy is to pre-process the `wordlist` into three distinct lookup tables,
     * one for each matching rule. This allows for efficient, near-O(1) lookups for each query.
     * The rules are then checked in their specified order of priority.
     *
     * - Parameters:
     * - wordlist: The list of correct words.
     * - queries: The list of queries to check.
     * - Returns: An array of corrected words corresponding to the queries.
     */
    func spellchecker(_ wordlist: [String], _ queries: [String]) -> [String] {
        
        // --- Helper function to create the "vowel error" pattern for a word ---
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        func devowel(_ word: String) -> String {
            // Lowercase the word and replace all vowels with a placeholder character.
            return String(word.lowercased().map { vowels.contains($0) ? "_" : $0 })
        }
        
        // --- Step 1: Pre-computation of Lookup Tables ---
        
        // For Rule 1: Exact, case-sensitive matches. A Set provides O(1) average time complexity.
        let exactMatches = Set(wordlist)
        
        // For Rule 2: Case-insensitive matches.
        // Key: lowercased word. Value: original word.
        let caseInsensitiveMatches = Dictionary(wordlist.map { ($0.lowercased(), $0) }) { first, _ in first }
        // The `uniquingKeysWith: { first, _ in first }` closure is crucial. If multiple words
        // map to the same key (e.g., "KiTe" and "kite"), it keeps the value from the *first*
        // word encountered in the original `wordlist`, as required by the problem.

        // For Rule 3: Vowel error matches.
        // Key: "devoweled" pattern. Value: original word.
        let vowelErrorMatches = Dictionary(wordlist.map { (devowel($0), $0) }) { first, _ in first }

        
        // --- Step 2: Process Each Query ---
        return queries.map { query in
            // Rule 1: Check for an exact, case-sensitive match.
            if exactMatches.contains(query) {
                return query
            }
            
            // Rule 2: Check for a case-insensitive match.
            let lowercasedQuery = query.lowercased()
            if let match = caseInsensitiveMatches[lowercasedQuery] {
                return match
            }
            
            // Rule 3: Check for a match ignoring vowels.
            let devoweledQuery = devowel(query)
            if let match = vowelErrorMatches[devoweledQuery] {
                return match
            }
            
            // Rule 4: If no matches are found, return an empty string.
            return ""
        }
    }
}