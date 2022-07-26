class Solution {
    func groupThePeople(_ groupSizes: [Int]) -> [[Int]] {
        var hashMap: [Int : [Int]] = [:]
        
        var index = 0
        for groupSize in groupSizes {
            let hashMapValue = hashMap[groupSize] ?? []
            hashMap[groupSize] = hashMapValue + [index]
            
            index += 1
        }
        
        var output: [[Int]] = []
        
        for (key, value) in hashMap {
            var originalGroup = value
            
            while originalGroup.count != key {
                var newGroup: [Int] = []
                
                for index in 0..<key {
                    newGroup.append(originalGroup[index])
                    originalGroup.remove(at: index)
                }
                
                output.append(newGroup)
            }
            
            output.append(originalGroup)
        }
        
        return output
    }
}