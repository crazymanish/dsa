class Solution {
    func evalRPN(_ tokens: [String]) -> Int {
        var stack: [Int] = []
        
        for token in tokens {
            let intToken = Int(token)
            
            if intToken != nil {
                stack.append(intToken!)
            } else {
                let first = stack.removeLast()
                let second = stack.removeLast()
                
                switch token {
                    case "+": stack.append(first + second)
                    case "-": stack.append(second - first)
                    case "/": stack.append(second / first)
                    case "*": stack.append(first * second)
                    default: break
                } 
            }
        }
        
        return stack.last ?? 0
    }
}