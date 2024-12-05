class Solution {
    func canChange(_ start: String, _ target: String) -> Bool {
        let startWithoutUnderscores = start.replacingOccurrences(of: "_", with: "")
        let targetWithoutUnderscores = target.replacingOccurrences(of: "_", with: "")
    
        if startWithoutUnderscores != targetWithoutUnderscores { return false }
    
        var startIndex = 0
        var targetIndex = 0
        let startArray = Array(start)
        let targetArray = Array(target)
    
        while startIndex < startArray.count && targetIndex < targetArray.count {
            if startArray[startIndex] == "_" {
                startIndex += 1
                continue
            }
        
            if targetArray[targetIndex] == "_" {
                targetIndex += 1
                continue
            }
        
            if startArray[startIndex] == "L" {
                if startIndex < targetIndex {
                    return false
                }
            } else if startArray[startIndex] == "R" {
                if startIndex > targetIndex {
                    return false
                }
            }
        
            startIndex += 1
            targetIndex += 1
        }
    
        return true
    }
}