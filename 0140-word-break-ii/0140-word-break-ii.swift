class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        let sChars = Array(s)
        var solutions = [String]()
        
        func build(_ index: Int, _ partialSolution: String) {
            if index >= sChars.count {
                if index == sChars.count {
                    solutions.append(partialSolution)
                }
                return
            }
            
            let substring = String(sChars[index...])
            for option in wordDict {
                if substring.hasPrefix(option) {
                    if index == 0 {
                        build(index + option.count, option)
                    } else {
                        build(index + option.count, partialSolution + " " + option)
                    }
                }
            }            
        }
        
        build(0, "")
        
        return solutions
    }
}