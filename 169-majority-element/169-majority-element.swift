class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        let target = nums.count / 2
        
        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }
        
        var output = -1
        for (key, value) in hashMap {
            if value > target { 
                output = key 
                break
            }
        }
        
        return output
    }
}