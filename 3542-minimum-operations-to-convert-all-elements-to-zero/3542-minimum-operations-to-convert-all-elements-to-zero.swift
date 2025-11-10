class Solution {
    /*
     Time Complexity: O(n)
     - Each element is pushed and popped from the stack at most once.
     
     Space Complexity: O(n)
     - The stack may hold up to n elements in the worst case.
    */
    
    func minOperations(_ nums: [Int]) -> Int {
        var stack: [Int] = []   // Keeps track of the increasing sequence
        var operationCount = 0  // Counts the number of operations performed
        
        for num in nums {
            // Ensure the stack is non-decreasing by popping larger elements
            while let last = stack.last, last > num {
                stack.removeLast()
            }
            
            // Skip zero values (they don't contribute to operations)
            guard num != 0 else { continue }
            
            // If the current number extends the increasing sequence,
            // it's a new "operation" point — we push it and increment count
            if stack.last ?? 0 < num {
                operationCount += 1
                stack.append(num)
            }
        }
        
        return operationCount
    }
}
