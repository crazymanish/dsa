class Solution {
    func findFinalValue(_ nums: [Int], _ original: Int) -> Int {
        var hashMap: [Int : Bool] = [:]
        
        for num in nums { hashMap[num] = true }
        
        var outputValue = original
        while hashMap[outputValue] != nil {
            outputValue *= 2
        }
        
        return outputValue
    }
}