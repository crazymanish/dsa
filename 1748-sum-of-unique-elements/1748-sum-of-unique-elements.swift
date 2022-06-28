class Solution {
    func sumOfUnique(_ nums: [Int]) -> Int {
        var hashMap: [Int : Bool] = [:]
        var uniqueElementsSum = 0
        
        for num in nums {
            if let hashMapValue = hashMap[num] {
                if hashMapValue {
                    hashMap[num] = false
                    uniqueElementsSum -= num   
                }
            } else {
                hashMap[num] = true
                uniqueElementsSum += num
            }
        }
        
        return uniqueElementsSum
    }
}