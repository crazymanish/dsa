class Solution {
    func isValid(_ s: String) -> Bool {
        let stack = Stack()
        
        for currentBracket in s {
            if currentBracket.isOpeningBracket {
                stack.push(currentBracket)
                continue   
            }
            
            guard let lastBracket = stack.pop() else { return false }
                
            if currentBracket == ")" && lastBracket != "(" { return false }
            if currentBracket == "}" && lastBracket != "{" { return false }
            if currentBracket == "]" && lastBracket != "[" { return false }
        }
        
        return stack.isEmpty
    }
}

extension Character {
    var isOpeningBracket: Bool { self == "(" || self == "{" || self == "[" }
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