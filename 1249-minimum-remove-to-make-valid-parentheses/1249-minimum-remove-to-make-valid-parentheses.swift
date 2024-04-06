class Solution {
    func minRemoveToMakeValid(_ s: String) -> String {
        var sArray = Array(s)
        var stack = [Int]()
        
        for (index, char) in sArray.enumerated() {
            if char == "(" {
                stack.append(index)
            } else if char == ")" {
                if stack.isEmpty {
                    sArray[index] = "*"
                } else {
                    stack.removeLast()
                }
            }
        }
        
        while !stack.isEmpty {
            let index = stack.removeLast()
            sArray[index] = "*"
        }
        
        return String(sArray).replacingOccurrences(of: "*", with: "")
    }
}