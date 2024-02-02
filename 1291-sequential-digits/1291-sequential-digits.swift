class Solution {
    func sequentialDigits(_ low: Int, _ high: Int) -> [Int] {
        var subResult: [Int] = [12,23,34,45,56,67,78,89]
        var result: [Int] = []
        
        while !subResult.isEmpty {
            for number in subResult {
                if number > high {
                    return result
                } else if number < low {
                    continue
                }
                
                result.append(number)
            }
            
            subResult.removeLast()
            
            for (index, number) in subResult.enumerated() {
                subResult[index] = 10 * number + number % 10 + 1
            }
        }
        
        return result
    }
}