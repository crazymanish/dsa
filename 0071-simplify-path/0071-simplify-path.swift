class Solution {
    func simplifyPath(_ path: String) -> String {
        var stack = [String]()
        var directories = path.components(separatedBy: "/")
        
        for directory in directories {
            if directory == ".." && !stack.isEmpty { stack.removeLast() }
            
            if ["..", ".", ""].contains(directory) { continue }
            
            stack.append(directory)
        }
        
        return "/" + stack.joined(separator: "/")
    }
}