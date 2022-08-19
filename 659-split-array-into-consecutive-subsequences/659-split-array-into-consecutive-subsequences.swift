class Solution {
    func isPossible(_ nums: [Int]) -> Bool {
        guard nums.count >= 3 else { return false }
        
        var frequencyMap: [Int: Int] = [:] // [num: frequency-count]
        for num in nums { frequencyMap[num, default: 0] += 1 }
        
        var subsequenceMap: [Int: Int] = [:] // [a_subsequence_last_num: frequency]
        
        for (index, num) in nums.enumerated() {
            if frequencyMap[num]! == 0 { continue }
            
            // update the existing subsequence
            if subsequenceMap[num-1, default: 0] > 0 {
                subsequenceMap[num-1]! -= 1
                subsequenceMap[num, default: 0] += 1
            }
            // can create a new subsequence
            else if frequencyMap[num+1, default: 0] > 0 
                 && frequencyMap[num+2, default: 0] > 0 {
                subsequenceMap[num+2, default: 0] += 1
                
                frequencyMap[num+1]! -= 1
                frequencyMap[num+2]! -= 1
            } else {
                return false         
            }
            
            frequencyMap[num]! -= 1
        }
        
        return true
    }
}
