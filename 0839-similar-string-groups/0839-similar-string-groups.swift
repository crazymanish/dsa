class Solution {
    func numSimilarGroups(_ A: [String]) -> Int {
        if A.count == 0 { return 0 }
        
        var result = 0
        var visited = Set<String>()
        
        func dfs(_ inputString: String) {
            if visited.contains(inputString) { return }
        
            visited.insert(inputString)
        
            for currentString in A {
                if isSimilar(currentString, inputString) {
                    dfs(currentString)
                }
            }
        }
    
        func isSimilar(_ s1: String, _ s2: String) -> Bool {
            var chars1 = Array(s1)
            var chars2 = Array(s2) 
            var count = 0
            
            for i in 0..<chars1.count {
                if chars1[i] != chars2[i] { count += 1 }
                if count > 2 { return false }
            }
        
            return count == 2 || count == 0
        }
        
        for inputString in A {
            if visited.contains(inputString) { continue }
            
            dfs(inputString)
            result += 1
        }
        
        return result
    }   
}