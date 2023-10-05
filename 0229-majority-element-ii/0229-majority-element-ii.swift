class Solution {
    func majorityElement(_ nums: [Int]) -> [Int] {
        if nums.isEmpty { return [0] }
        
        var hashMap = [Int : Int]()
        for num in nums {
            hashMap[num, default: 0] += 1
        }

        var result = [Int]()
        for (key, value) in hashMap where value > nums.count / 3 {
            result.append(key)
        }
        
        return result
    }
}