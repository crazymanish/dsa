class Solution {
    func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
        typealias CharIsExistMap = [Character : Bool]
        var hashMap: CharIsExistMap = [:]
        
        for jewel in jewels {
            hashMap[jewel] = true
        }
        
        var output = 0
        for stone in stones {
            if hashMap[stone] != nil { output += 1 }
        }
        
        return output
    }
}