class Solution {
    func distributeCandies(_ candyTypes: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        
        for candyType in candyTypes {
            if let hashMapValue = hashMap[candyType] {
                hashMap[candyType] = hashMapValue + 1
            } else {
                hashMap[candyType] = 1
            }
        }
        
        return min(candyTypes.count/2, hashMap.keys.count)
    }
}