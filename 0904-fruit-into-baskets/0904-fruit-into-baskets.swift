class Solution {
    func totalFruit(_ fruits: [Int]) -> Int {
        var hashMap: [Int : Int] = [:]
        var maxPickedFruit = 0
        
        var startIndex = 0
        for (endIndex, fruit) in fruits.enumerated() {
            hashMap[fruit] = endIndex
            
            if hashMap.keys.count == 3 {
                let minKey = Array(hashMap.values).min()!
                let minIndex = hashMap[fruits[minKey]]!
                
                hashMap[fruits[minKey]] = nil
                startIndex = minIndex + 1
            }
            
            maxPickedFruit = max(endIndex - startIndex + 1, maxPickedFruit)
        }
        
        return maxPickedFruit 
    }
}