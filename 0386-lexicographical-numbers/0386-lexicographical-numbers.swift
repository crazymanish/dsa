// Time Complexity: O(n)
// The recursive function `generateLexically` is invoked for each integer from 1 to n
// exactly once. Inside each function call, the operations (appending to an array,
// arithmetic, and comparison) are all constant time, O(1). Therefore, the overall
// time complexity is directly proportional to n.
//
// Space Complexity: O(n)
// The space complexity is determined by two factors:
// 1. The output array `lexicalNumbers`, which stores n integers, requires O(n) space.
// 2. The recursion call stack. The maximum depth of the recursion is determined by the
//    number of digits in n, which is O(log_10(n)).
// Since O(n) is the dominant term, the total space complexity is O(n).

class Solution {
    /// Generates a list of integers from 1 to n in lexicographical order.
    /// For example, for n = 13, the output is [1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9].
    func lexicalOrder(_ n: Int) -> [Int] {
        // Stores the final list of numbers in lexicographical order.
        var lexicalNumbers = [Int]()
        
        /// A recursive helper function that performs a Depth-First Search (DFS)
        /// over the conceptual tree of numbers.
        /// - Parameter currentNumber: The number to process at the current step.
        func generateLexically(from currentNumber: Int) {
            // Base Case: If the current number is greater than the upper bound n,
            // we have gone too far, so we stop exploring this path.
            if currentNumber > n { return }
            
            // Process the current node: add the valid number to our result list.
            lexicalNumbers.append(currentNumber)
            
            // --- Recursive Step 1: Explore the "child" node. ---
            // This corresponds to moving one level deeper in the number tree.
            // For example, from 1 we explore 10; from 12 we explore 120.
            // This ensures that numbers with more digits but the same prefix are visited first.
            generateLexically(from: currentNumber * 10)
            
            // --- Recursive Step 2: Explore the "sibling" node. ---
            // This moves to the next number at the same level, e.g., from 1 to 2, or from 12 to 13.
            // We only do this if the last digit is not 9. Incrementing a number ending in 9
            // (like 19 to 20) would jump to the next decade. This transition is naturally
            // handled when the recursion backtracks and the parent node moves to its sibling
            // (e.g., after the '1' branch is fully explored, we move to '2').
            if currentNumber % 10 < 9 {
                generateLexically(from: currentNumber + 1)
            }
        }
        
        // The lexicographical order starts with 1.
        generateLexically(from: 1)
        
        return lexicalNumbers
    }
}