class Solution {
    func makeGood(_ s: String) -> String {
        var stack : [Character] = []
        
        for character in s {
            if stack.isEmpty {
                stack.append(character)
            } else {
                if stack.last?.uppercased() == String(character) && stack.last!.isLowercase && character.isUppercase {
                    stack.popLast()
                } else if stack.last?.lowercased() == String(character) && character.isLowercase && stack.last!.isUppercase {
                    stack.popLast()
                } else {
                    stack.append(character)
                }
            }
        }
        
        return String(stack)
    }
}