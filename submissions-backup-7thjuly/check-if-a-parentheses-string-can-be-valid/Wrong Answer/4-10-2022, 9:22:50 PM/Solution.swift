// https://leetcode.com/problems/check-if-a-parentheses-string-can-be-valid

class Solution {
    func canBeValid(_ s: String, _ locked: String) -> Bool {
        let lockedArray = Array(locked)
        let stack = Stack()
        
        var index = 0
        for char in s {
            if char.isOpeningBracket {
                stack.push(char)
            } else {
                if let stackChar = stack.pop() {
                    if stackChar.isClosingBracket && lockedArray[index] == "1" { return false }
                } else {
                    if lockedArray[index] == "1" { stack.push(char) }
                    if lockedArray[index] == "0" { stack.push("(") }
                }
            }
            
            index += 1
        }
        
        return stack.isEmpty
    }
}

extension Character {
    var isOpeningBracket: Bool { self == "(" }
    var isClosingBracket: Bool { self == ")" }
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