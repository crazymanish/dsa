class Solution {
    func reverseParentheses(_ s: String) -> String {
        var stack = [Character]()

        for char in s {
            if char == ")" {
                // Look for matching "(".
                let index = stack.lastIndex(of: "(")!

                // Reverse characters between "(" and ")".
                let suffix = stack[(index + 1)...]
                stack.removeLast(stack.count - index)
                stack.append(contentsOf: suffix.reversed())
            } else {
                stack.append(char)
            }
        }

        return String(stack)
    }
}