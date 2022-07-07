// https://leetcode.com/problems/check-if-a-parentheses-string-can-be-valid

class Solution {
    func canBeValid(_ s: String, _ locked: String) -> Bool {
        let lockedArray = Array(locked)
        let stack = Stack()
        
        var index = 0
        for currentChar in s {
            if stack.isEmpty {
                if lockedArray[index] == "1" { stack.push(currentChar) }
                if lockedArray[index] == "0" { stack.push("(") }
            } else {
                let lastChar = stack.top!
                if lastChar.isOpeningBracket && currentChar.isClosingBracket { stack.pop() }
                else if lastChar.isOpeningBracket && currentChar.isOpeningBracket && lockedArray[index] == "0" { stack.pop() }
                else if lockedArray[index] == "1" { stack.push(currentChar) }
                else if lockedArray[index] == "0" { stack.push("(") }
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
    var array: [Character] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    var top: Character? { array.last }
    
    func push(_ element: Character) {
        array.append(element)
    }
    
    func pop() -> Character? {
        if isEmpty { return nil }
        
        return array.removeLast()
    }
}