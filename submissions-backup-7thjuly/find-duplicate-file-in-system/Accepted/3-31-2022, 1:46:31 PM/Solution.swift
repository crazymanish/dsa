// https://leetcode.com/problems/find-duplicate-file-in-system

class Solution {
    func findDuplicate(_ paths: [String]) -> [[String]] {
        var hashMap: [String : [String]] = [:]
        
        for path in paths {
            let components = path.components(separatedBy: " ")
            let root = components[0]
            
            for index in 1..<components.count {
                let path = components[index]
                let keyValuePair = path.components(separatedBy: "(")
                let key = keyValuePair[1]
                let value = root + "/" + keyValuePair[0]
                
                let hashMapValue = hashMap[key] ?? []
                hashMap[key] = hashMapValue + [value]
            }
        }
        
        var output: [[String]] = []
        for (_, value) in hashMap {
            if value.count > 1 { output.append(value) }
        }
        
        return output
    }
}