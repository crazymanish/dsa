class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var startIndex = 0
        var endIndex = numbers.count-1
        
        while startIndex < endIndex {
            let twoSum = numbers[startIndex] + numbers[endIndex]
            
            if twoSum == target {
                return [startIndex+1, endIndex+1] // found answer
            } else if twoSum > target {
                endIndex -= 1
            } else {
                startIndex += 1
            }
        }
        
        return [-1, -1] // Not found
    }
}