// https://leetcode.com/problems/random-pick-index


class Solution {
    var hashMap: [Int : [Int]] = [:]

    init(_ nums: [Int]) {
        var index = 0 
        for num in nums {
            let hashMapValue = hashMap[num] ?? []
            hashMap[num] = hashMapValue + [index]

            index += 1
        }
    }
    
    func pick(_ target: Int) -> Int {
        let indexArray = hashMap[target]!
        let randomIndex = Int.random(in: 0..<indexArray.count)
        
        return indexArray[randomIndex]
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: Int = obj.pick(target)
 */