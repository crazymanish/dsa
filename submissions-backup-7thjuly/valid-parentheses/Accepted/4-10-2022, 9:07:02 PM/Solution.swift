// https://leetcode.com/problems/valid-parentheses

class Solution {
    func isValid(_ s: String) -> Bool {
        let stack = Stack()
        
        for char in s {
            if char.isOpeningBracket {
                stack.push(char)
            } else {
                if let openingBracket = stack.pop() {
                    if char == ")" && openingBracket != "(" { return false }
                    if char == "}" && openingBracket != "{" { return false }
                    if char == "]" && openingBracket != "[" { return false }
                } else {
                    return false
                }
            }
        }
        
        return stack.isEmpty
    }
}

extension Character {
    var isOpeningBracket: Bool { self == "(" || self == "{" || self == "[" }
    var isClosingBracket: Bool { self == ")" || self == "}" || self == "]" }
}

class Stack {
    private var array: [Character] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    func push(_ element: Character) {
        array.append(element)
    }
    
    func pop() -> Character? {
        if isEmpty { return nil }
        
        return array.removeLast()
    }
}