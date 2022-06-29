class Solution {
    func repeatedNTimes(_ nums: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        let expectedRepeatedCount = nums.count / 2
        
        var outputRepeatedNumber = 0
        
        for num in nums {
            if let hashMapCount = hashMap[num] {
                let newHashMapCount = hashMapCount - 1
                
                if newHashMapCount == 1 {
                    outputRepeatedNumber = num
                    break
                }
                
                hashMap[num] = newHashMapCount
            } else {
                hashMap[num] = expectedRepeatedCount
            }
        }
        
        return outputRepeatedNumber
    }
}