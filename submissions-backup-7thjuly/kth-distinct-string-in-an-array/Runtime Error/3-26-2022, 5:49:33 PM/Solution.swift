// https://leetcode.com/problems/kth-distinct-string-in-an-array

class Solution {
    func kthDistinct(_ arr: [String], _ k: Int) -> String {
        var hashMap: [String : Bool] = [:]
        var distinctElements: [String] = []
        
        for element in arr {
            if hashMap[element] == nil {
                hashMap[element] = true
                distinctElements.append(element)
            } else {
                let index = distinctElements.index(of:element)!
                distinctElements.remove(at: index)
            }
        }
        
        if distinctElements.count >= k {
            return distinctElements[k-1]   
        }
        
        return ""
    }
}