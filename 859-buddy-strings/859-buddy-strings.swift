class Solution {
    func buddyStrings(_ s1: String, _ s2: String) -> Bool {
        guard s1.count == s2.count else { return false }
        
        if s1 == s2 {
            return Set(s1).count < s1.count
        } else {
            var diffs: [Int] = []
            let array1 = Array(s1) 
            let array2 = Array(s2)
            
            for index in 0..<array1.count {
                if array1[index] != array2[index] {
                    diffs.append(index)
                }
            }
            
            guard diffs.count == 2 else { return false }
            
            let i = diffs[0] 
            let j = diffs[1]
            
            return array1[i] == array2[j] && array1[j] == array2[i]
        }
    }
}