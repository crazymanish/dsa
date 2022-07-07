// https://leetcode.com/problems/group-anagrams

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        if strs.count == 1 { return [strs] }
        
        var hashMap: [String : [String]] = [:]
        
        for str in strs {
            let sortedStr = String(str.sorted())
            
            let hashMapValue = hashMap[sortedStr] ?? []
            hashMap[sortedStr] = hashMapValue + [str]
        }
        
        return Array(hashMap.values)
    }
}