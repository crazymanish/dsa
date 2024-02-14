class Solution {
    func rearrangeArray(_ nums: [Int]) -> [Int] {
        var positiveNumbers: [Int] = []
        var negativeNumbers: [Int] = []
        
        for num in nums {
            if num > 0 {
                positiveNumbers.append(num)
            } else {
                negativeNumbers.append(num)
            }
        }
        
        var output: [Int] = []
        
        for index in 0..<positiveNumbers.count {
            output.append(positiveNumbers[index])
            output.append(negativeNumbers[index])
        }
        
        return output
    }
}