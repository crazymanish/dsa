class Solution {
    func decodeString(_ s: String) -> String {
        if s.isEmpty { return "" }

        let stack = Stack()
        var k = ""
        
        for char in s {
            let stringInfo = StringInfo(char)
            
            if stringInfo.intValue == nil {
                stack.push(StringInfo(k))
                k = ""
                handleNonIntStringInfo(stringInfo, stack)
            } else {
                k += stringInfo.string   
            }
        }

        var output = ""
        while stack.isEmpty == false {
            output = stack.pop()!.string + output
        }

        return output
    }
    
    private func handleNonIntStringInfo(_ stringInfo: StringInfo, _ stack: Stack) {
        if stringInfo.isCloseBracket {
            var bracketString = ""
            while stack.top!.isOpenBracket == false {
                bracketString = stack.pop()!.string + bracketString
            }
            stack.pop()

            var calculatedString = ""
            let count = stack.pop()!.intValue!
            for _ in 0..<count {
                calculatedString += bracketString
            }
            stack.push(StringInfo(calculatedString))
        } else {
            stack.push(stringInfo)
        }
    }
}

private class StringInfo {
    let string: String

    init(_ char: Character) {
        self.string = String(char)
    }

    init(_ string: String) {
        self.string = string
    }

    var isOpenBracket: Bool { string == "[" }
    var isCloseBracket: Bool { string == "]" }
    var intValue: Int? { Int(string) }
}

private class Stack {
    private var array: [StringInfo] = []

    var isEmpty: Bool { array.isEmpty }

    var top: StringInfo? { array.last }

    func push(_ element: StringInfo) {
        array.append(element)
    }

    @discardableResult
    func pop() -> StringInfo? {
        if array.isEmpty { return nil }

        return array.removeLast()
    }
}
