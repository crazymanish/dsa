class Solution {
    func removeKdigits(_ num: String, _ k: Int) -> String {
        guard num.count >= k else { return "0" }
        
        var stack = ""
        var removeCount = 0
        var canRemove: Bool { removeCount < k && !stack.isEmpty }
            
        // Create monotonically increasing stack
        for digit in num {
            // While we have removes, try to ensure leading digits are in ascending order, use removes to remove current digits in the stack that exceed the current digits value 
            while canRemove, let topDigit = stack.last, digit < topDigit  {
                stack.removeLast()
                removeCount += 1
            }

            // We can skip inserting zeros if the stack is empty, as they'd be leading zeros.
            if stack.isEmpty && digit == "0" { continue }

            // assuming we ran out of removes, append all remaining digits, though this will only run if we run out of removes BEFORE finish iterating over all digits.
            stack.append(digit)
        }
            
        // If we have not used all of our "removes" yet, we should do that
        // As we know the top of the stack has the largest digit, we just need to pop the top element until we reach our max pop count
        while canRemove {
            stack.removeLast()
            removeCount += 1
        }
            
        // the stack could be empty, if so, return zero
        return stack.isEmpty ? "0" : stack
    }
}