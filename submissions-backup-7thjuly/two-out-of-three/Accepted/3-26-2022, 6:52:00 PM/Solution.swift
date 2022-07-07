// https://leetcode.com/problems/two-out-of-three

class Solution {
    func twoOutOfThree(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int]) -> [Int] {
        var hashMap: [Int : [Int : Bool]] = [:]
        
        for num in nums1 {
            if hashMap[num] == nil { 
                hashMap[num] = [1 : true] 
            }
        }
        
        for num in nums2 {
            if var hashMapValue = hashMap[num] { 
                if hashMapValue[2] == nil {
                    hashMapValue[2] = true
                    hashMap[num] = hashMapValue
                }
            } else {
                hashMap[num] = [2 : true] 
            }
        }
        
        for num in nums3 {
            if var hashMapValue = hashMap[num] { 
                if hashMapValue[3] == nil {
                    hashMapValue[3] = true
                    hashMap[num] = hashMapValue
                }
            } else {
                hashMap[num] = [3 : true] 
            }
        }
        
        
        var output: [Int] = []
        for (key, value) in hashMap {
            if value.keys.count > 1 { output.append(key) }
        }
        
        return output
    }
}