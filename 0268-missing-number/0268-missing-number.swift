class Solution {
    func missingNumber(_ numbers: [Int]) -> Int {
        let sortedNumbers = numbers.sorted()
        
        var missingNumber = -1
        
        var index = 0
        for number in sortedNumbers {
            if number != index {
                missingNumber = index
                break
            }
            
            index += 1
        }
        
        if missingNumber == -1 {  return numbers.count }
        
        return missingNumber
    }
}
