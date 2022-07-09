class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var hashMap: [Int: Bool] = [:]
        
        var containsDuplicate = false
        
        for num in nums {
            if hashMap[num] == nil {
                hashMap[num] = true
            } else {
                containsDuplicate = true
                break
            }
        }
        
        return containsDuplicate
    }
}