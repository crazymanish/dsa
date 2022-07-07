// https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array

class Solution {
    func findDisappearedNumbers(_ numbers: [Int]) -> [Int] {
        var hashMap: [Int : Bool] = [:]
        for number in numbers { hashMap[number] = true }

        var disappearedNumbers: [Int] = []
        
        for number in 1...numbers.count {
            if hashMap[number] == nil { disappearedNumbers.append(number) }
        }
        
        return disappearedNumbers
    }
}
