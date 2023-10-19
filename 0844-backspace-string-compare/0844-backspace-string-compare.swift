class Solution {
    func backspaceCompare(_ s: String, _ t: String) -> Bool {
        func removeBackspace(_ string: String) -> [Character] {
            let stack = Stack()
        
            for char in string {
                if char == "#" {
                    stack.pop()
                } else {
                    stack.push(char)
                }
            }
        
            var output: [Character] = []
            while stack.isEmpty == false {
                output.append(stack.pop()!)
            }
        
            return output
        }
        
        let sChars = removeBackspace(s)
        let tChars = removeBackspace(t)
        
        return sChars == tChars
    }
}

class Stack {
    private var array: [Character] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    func push(_ char: Character) {
        array.append(char)
    }
    
    func pop() -> Character? {
        if isEmpty { return nil }
        
        return array.removeLast()
    }
}