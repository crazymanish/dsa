class Solution {
    enum Op {
        case add
        case subtract
        
        func apply(first: Int, second:Int) -> Int {
            switch self {
                case .add: return first + second
                case .subtract: return first - second 
            }
        }
    }
    
    func calculate(_ s: String) -> Int {
        // Stack that stores the previous sum when we see a new paranthesis
        var stack = [(Int, Op)]()
        
        var index = 0
        let sList = Array(s)
        let sCount = sList.count
        
        // Stores the current sum
        var currentSum = 0
        // Stores the current operation
        var currentOp: Op = .add
        
        while index < sCount {
            let char = sList[index]
            if char.isNumber {
                // If the current element is a number get the complete number
                var currentNumber = 0
                while index < sCount && sList[index].isNumber {
                    currentNumber = currentNumber * 10 + sList[index].wholeNumberValue!
                    index += 1
                }
                currentSum = currentOp.apply(first: currentSum, second: currentNumber)
                continue
            } else if char == "-" {
                currentOp = .subtract
            } else if char == "+" {
                currentOp = .add
            } else if char == "(" {
                // If we see a open paranthesis put the current sum and operation on the stack
                // and reset the sum and the operation
                stack.append((currentSum, currentOp))
                currentSum = 0
                currentOp = .add
            } else if char == ")" {
                // if we see a closing paranthesis 
                // pop the stack and update the current sum
                if !stack.isEmpty {
                    let (prevSum, prevOp) = stack.removeLast()
                    currentSum = prevOp.apply(first: prevSum, second: currentSum)
                }
            }
            index += 1
        }
        return currentSum
    }
}