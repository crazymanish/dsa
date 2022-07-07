// https://leetcode.com/problems/the-score-of-students-solving-math-expression

class Solution {
    func scoreOfStudents(_ s: String, _ answers: [Int]) -> Int {
        let allCorrectAnswers = ComputeSolution().diffWaysToCompute(s)

        var correctAnswerHashMap: [Int : Int] = [:]
        for answer in allCorrectAnswers { correctAnswerHashMap[answer] = 2 } // 2 score for all correct answers

        let correctAnswer = computeExpression(s)
        correctAnswerHashMap[correctAnswer] = 5 // 5 score for correct answer

        var scoreOfStudents = 0
        for answer in answers {
            if let score = correctAnswerHashMap[answer] { scoreOfStudents += score }
        }

        return scoreOfStudents
    }

    // Same code as 241. Different Ways to Add Parentheses
    // https://leetcode.com/problems/different-ways-to-add-parentheses/
    private func diffWaysToCompute(_ input: String, _ cache: inout [String : [Int]]) -> [Int] {
        var output: [Int] = []

        for (index, char) in input.enumerated() {
            if char == "+" || char == "-" || char == "*" {
                let leftEndIndex = input.index(input.startIndex, offsetBy: index)
                let rightStartIndex = input.index(input.startIndex, offsetBy: index+1)
                let leftString = String(input.prefix(upTo: leftEndIndex))
                let rightString = String(input.suffix(from: rightStartIndex))

                let leftResults = cache[leftString] ?? diffWaysToCompute(leftString, &cache)
                let rightResults = cache[rightString] ?? diffWaysToCompute(rightString, &cache)

                for leftResult in leftResults {
                    for rightResult in rightResults {
                        if char == "+" { output.append(leftResult + rightResult) }
                        if char == "-" { output.append(leftResult - rightResult) }
                        if char == "*" { output.append(leftResult * rightResult) }
                    }
                }
            }
        }

        if output.count == 0 { output.append(Int(input)!) }

        cache[input] = output // Update cache

        return output
    }

    private func computeExpression(_ input: String) -> Int {
        // Function to find precedence of operators.
        func precedence(_ op: Character) -> Int {
            if(op == "+" || op == "-") { return 1 }
            if(op == "*" || op == "/") { return 2 }

            return 0
        }

        // Function to perform arithmetic operations.
        func applyOp(_ a: Int, _ b: Int, _ op: Character) -> Int {
            switch(op) {
                case "+": return a + b
                case "-": return a - b
                case "*": return a * b
                case "/": return a / b
                default: return 0
            }
        }

        let values = Stack<Int>()
        let ops = Stack<Character>()
        let tokens = Array(input)

        var i = 0
        while i < tokens.count {
            // Current token is a whitespace, skip it.
            if tokens[i] == " " { continue }

            // Current token is a number, push it to stack for numbers
            if (tokens[i] >= "0" && tokens[i] <= "9") {
                var numberString = ""

                // There may be more than one digits in number
                while (i < tokens.count && tokens[i] >= "0" && tokens[i] <= "9") {
                    numberString += String(tokens[i])
                    i += 1
                }

                values.push(Int(numberString)!)

               // right now the i points to the character next to the digit,
               // since the for loop also increases the i, we would skip one
               //  token position; we need to decrease the value of i by 1 to correct the offset.
               i -= 1
            }
            // Current token is an operator.
            else if (tokens[i] == "+" || tokens[i] == "-" || tokens[i] == "*" || tokens[i] == "/") {
                // While top of 'ops' has same or greater precedence to current token, which
                // is an operator. Apply operator on top of 'ops' to top two elements in values stack.
                while ops.isEmpty == false && precedence(ops.top!) >= precedence(tokens[i]) {
                    let val2 = values.pop()!
                    let val1 = values.pop()!
                    let op = ops.pop()!

                    let result = applyOp(val1, val2, op)
                    values.push(result)
                }

                // Push current token to 'ops'.
                ops.push(tokens[i])
            }

            i += 1
        }

        // Entire expression has been parsed at this point, apply remaining ops to remaining values.
        while ops.isEmpty == false {
            let val2 = values.pop()!
            let val1 = values.pop()!
            let op = ops.pop()!

            let result = applyOp(val1, val2, op)
            values.push(result)
        }

        return values.top!
    }
}

class Stack<T> {
    private var array: [T] = []

    var isEmpty: Bool { return array.isEmpty }

    var count: Int { return array.count }

    var top: T? { array.last }

    func push(_ value: T) {
        array.append(value)
    }

    func pop() -> T? {
        if isEmpty { return nil }

        return array.removeLast()
    }
}

class ComputeSolution {
    typealias CharArrSlice = ArraySlice<Character>
    let charIntMap : [Character: Int] = [
        "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9
    ]

    func diffWaysToCompute(_ input: String) -> [Int] {
        var cache = [CharArrSlice: [Int]]()
        return diffWaysToCompute(Array(input)[0...], &cache)
    }
    
    func diffWaysToCompute(_ input: CharArrSlice, _ cache: inout [CharArrSlice: [Int]]) -> [Int] {
        if let result = cache[input] {
            return result
        }
        
        var result = [Int](), singleNum = 0
        for i in input.indices {
            if let digit = charIntMap[input[i]] {
                singleNum = singleNum * 10 + digit
            } else {
                singleNum = 0
                for lhs in diffWaysToCompute(input[input.startIndex..<i], &cache) {
                    for rhs in diffWaysToCompute(input[i+1..<input.endIndex], &cache) {
                        switch input[i] {
                        case "+": result.append(lhs + rhs)
                        case "-": result.append(lhs - rhs)
                        case "*": result.append(lhs * rhs)
                        default:  fatalError()
                        }
                    }
                }
            }
        }
        
        if result.isEmpty {
            result = [singleNum]
        }
        
        cache[input] = result
        return result
    }
}