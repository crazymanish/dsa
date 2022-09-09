class Solution {
    func numberOfWeakCharacters(_ properties: [[Int]]) -> Int {
        // It is key to sort array of properties by attack in ascending order, and defense is descending order
        // Doing this ensures that during later on comparison with "MaxTillNow" it is a valid case to add on to count
        var properties = properties.sorted(by: {$0[0] < $1[0] || ($0[0] == $1[0] && $0[1] > $1[1] ) })
        
        var maxTillNow = Int.min, count = properties.count
        var maxCount = 0
        
        for i in stride(from:count-1, through: 0, by: -1) {
            if properties[i][1] < maxTillNow {
                maxCount+=1
            }
            
            maxTillNow = max(properties[i][1],maxTillNow )
        }
        
        return maxCount
    }
    
    // TLE
    func numberOfWeakCharacters1(_ properties: [[Int]]) -> Int {
        var properties = properties.sorted(by: sortProperties)
        
        func sortProperties(_ property1: [Int], _ property2: [Int]) -> Bool {
            if property1[0] != property2[0] {
                return property1[0] > property2[0]
            } else {
                return property1[1] < property2[1]
            }
        }

        var result = 0
        var maxDefense = Int.min
        
        for property in properties {
            let currentDefense = property[1]
            
            if currentDefense < maxDefense  { result += 1 } 
            
            maxDefense = max(maxDefense, currentDefense)
        }
        
        return result
    }
}