// https://leetcode.com/problems/letter-case-permutation

class Solution {
    func letterCasePermutation(_ s: String) -> [String] {
        let lastIndex = s.count-1
        let sArray = Array(s)
        var allSubsets: Set<String> = []
        var lowercaseSubset: String = ""
        var uppercaseSubset: String = ""
        
        func findAllSubSets(_ currentIndex: Int) {
            if currentIndex > lastIndex { 
                allSubsets.insert(lowercaseSubset)
                allSubsets.insert(uppercaseSubset)
                return 
            }
            
            let currentIndexValue = String(sArray[currentIndex])
            
            // Choice1: 
            // - add Uppercase value into uppercaseSubset
            // - add Lowercase value into lowercaseSubset
            uppercaseSubset += currentIndexValue.uppercased()
            lowercaseSubset += currentIndexValue.lowercased()
            findAllSubSets(currentIndex+1)
            uppercaseSubset.removeLast() // backtracking
            lowercaseSubset.removeLast() // backtracking   
            
            // Choice1: Reverse
            // - add Lowercase value into uppercaseSubset
            // - add Uppercase value into lowercaseSubset
            uppercaseSubset += currentIndexValue.lowercased()
            lowercaseSubset += currentIndexValue.uppercased()
            findAllSubSets(currentIndex+1)
            uppercaseSubset.removeLast() // backtracking
            lowercaseSubset.removeLast() // backtracking 
        }
        
        findAllSubSets(0)
        return Array(allSubsets)
    }
}