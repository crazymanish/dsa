class Solution {
    /**
     Problem Summary:
     Given two strings `s1` and `s2`, determine if they can be made equal by swapping characters 
     at even indices among themselves and odd indices among themselves any number of times.
     
     Strategy:
     - Characters at even indices can only move within even positions.
     - Characters at odd indices can only move within odd positions.
     - Therefore, for both strings:
         1. Count frequency of characters at even indices
         2. Count frequency of characters at odd indices
     - If both even-frequency maps and odd-frequency maps match, return true.
     
     Time Complexity:
     O(n) — single pass through both strings
     
     Space Complexity:
     O(1) — bounded by alphabet size (constant for lowercase letters)
     */
    
    func canBeEqual(_ firstString: String, _ secondString: String) -> Bool {
        // Build frequency maps for both strings
        let (firstEvenFreq, firstOddFreq) = buildParityFrequencies(from: firstString)
        let (secondEvenFreq, secondOddFreq) = buildParityFrequencies(from: secondString)
        
        // Compare even and odd frequency distributions
        return firstEvenFreq == secondEvenFreq && firstOddFreq == secondOddFreq
    }
    
    /// Builds frequency dictionaries for even and odd indices separately
    private func buildParityFrequencies(from string: String) -> ([Character: Int], [Character: Int]) {
        var evenIndexFrequency: [Character: Int] = [:]
        var oddIndexFrequency: [Character: Int] = [:]
        
        for (index, character) in string.enumerated() {
            if index % 2 == 0 {
                // Count character at even index
                evenIndexFrequency[character, default: 0] += 1
            } else {
                // Count character at odd index
                oddIndexFrequency[character, default: 0] += 1
            }
        }
        
        return (evenIndexFrequency, oddIndexFrequency)
    }
}