// https://leetcode.com/problems/sort-array-by-parity

class Solution {
    func sortArrayByParity(_ nums: [Int]) -> [Int] {
        var hashMap: [Int: [Int]] = [0 : [], 1: []]
        
        for num in nums {
            if num.isEven {
                hashMap[0] = hashMap[0]! + [num]
            } else {
                hashMap[1] = hashMap[1]! + [num]
            }
        }
        
        return Array(hashMap[0]!) + Array(hashMap[1]!)
    }
}

extension Int {
    var isEven: Bool { self % 2 == 0 }
}