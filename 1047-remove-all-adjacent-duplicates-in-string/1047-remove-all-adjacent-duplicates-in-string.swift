class Solution {
    func removeDuplicates(_ s: String) -> String {
        var stack: [Character] = []
        
        for character in s {
            if stack.count > 0 {
                if stack.last ?? " " == character {
                    stack.removeLast()
                } else {
                    stack.append(character)
                }
            } else {
                stack.append(character)
            }
        }
        
        return String(stack)
    }
}