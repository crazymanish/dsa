class Solution {
    func findDifferentBinaryString(_ nums: [String]) -> String {
        let lastIndex = nums.count-1
        var answer: String? = nil
        var currentSubset: String = ""
        
        func findAllSubSets(_ currentIndex: Int) {
            // means, we already have answer, no more looking
            if answer != nil { return }
            
            // Base case, when we found one subset
            if currentIndex > lastIndex { 

                // Update answer if this does not contain in input nums array
                if nums.contains(currentSubset) == false {
                    answer = currentSubset
                }
                
                return 
            }
            
            // Choice1:add "0" value into currentSubset
            currentSubset += "0"
            findAllSubSets(currentIndex+1)
            currentSubset.removeLast() // backtracking
            
            // Choice2:add "1" value into currentSubset
            currentSubset += "1"
            findAllSubSets(currentIndex+1)
            currentSubset.removeLast() // backtracking
        }
        
        findAllSubSets(0)
        return answer ?? ""
    }
}