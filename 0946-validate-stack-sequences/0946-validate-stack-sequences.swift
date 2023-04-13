class Solution {
    func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
        var stack: [Int] = []
        var index = 0
        
        for pushedValue in pushed {
            stack.append(pushedValue)
            
            while index < popped.count && popped[index] == stack.last {
                stack.popLast()
                index += 1
            }
        }
        
        return stack.isEmpty
    }
}