class Solution {
    func buildArray(_ target: [Int], _ n: Int) -> [String] {
        var targetIndex = 0
        var currentNumber = 1
        
        var output: [String] = []
        
        while currentNumber <= n && targetIndex < target.count  {
            let currentTargetNumber = target[targetIndex]
            
            if currentTargetNumber == currentNumber {
                output += ["Push"]
                targetIndex += 1
            } else {
                output += ["Push", "Pop"]
            }
            
            currentNumber += 1
        }
        
        return output
    }
}