class Solution {
    func countLargestGroup(_ n: Int) -> Int {
        var hashMap: [Int : Int] = [:]
        
        var mutatedN = n
        while mutatedN > 0 {
            var number = mutatedN
            var numberSum = 0
            while number > 0 {
                numberSum += number % 10
                number /= 10
            }
            
            if let hashMapValue = hashMap[numberSum] {
                hashMap[numberSum] = hashMapValue + 1
            } else {
                hashMap[numberSum] = 1
            }
            
            mutatedN -= 1
        }
        
        var groupHashMap: [Int : Int] = [:]
        for (_, value) in hashMap {
            if let hashMapValue = groupHashMap[value] {
                groupHashMap[value] = hashMapValue + 1
            } else {
                groupHashMap[value] = 1
            }
        }
        
        var largestGroup: (key: Int, value: Int) = (key: Int.min, value: Int.min)
        for (key, value) in groupHashMap {
            if key > largestGroup.key {
                largestGroup = (key: key, value: value)
            }
        }
        
        return largestGroup.value
    }
}