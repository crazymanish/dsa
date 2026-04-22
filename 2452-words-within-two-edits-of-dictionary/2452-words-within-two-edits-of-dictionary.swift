/**
 Problem Summary:
 Given two arrays of strings `queries` and `dictionary`, return all words from `queries`
 that differ by **at most 2 characters** from any word in `dictionary`.

 Strategy:
 - For each query word:
   - Compare it against every word in the dictionary.
   - Count character mismatches.
   - If mismatches ≤ 2, include the query in the result.
 - Stop early when mismatches exceed 2 for efficiency.

 Time Complexity:
 O(Q * D * L)
 - Q = number of queries
 - D = number of dictionary words
 - L = length of each word

 Space Complexity:
 O(1) (excluding output)
 */

class Solution {
    func twoEditWords(_ queries: [String], _ dictionary: [String]) -> [String] {
        // Check if a query word matches any dictionary word within ≤ 2 edits
        func isValidQuery(_ queryWord: String) -> Bool {
            // Compare two words and check if they differ by at most 2 characters
            func differsByAtMostTwo(_ word1: String, _ word2: String) -> Bool {
                guard word1.count == word2.count else { return false }
                
                var mismatchCount = 0
                var index = word1.startIndex
                
                // Traverse both words simultaneously
                while index != word1.endIndex {
                    if word1[index] != word2[index] {
                        mismatchCount += 1
                        
                        // Early exit if more than 2 mismatches
                        if mismatchCount > 2 {
                            return false
                        }
                    }
                    index = word1.index(after: index)
                }
                
                return true
            }
            
            // Check against all dictionary words
            return dictionary.contains { differsByAtMostTwo(queryWord, $0) }
        }
        
        // Filter queries that satisfy the condition
        return queries.filter { isValidQuery($0) }
    }
}