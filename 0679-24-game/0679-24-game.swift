// Time Complexity: O(1)
// The input size is always fixed at 4 cards. The algorithm explores a constant,
// finite number of combinations and permutations of operations.
// - At n=4, there are C(4,2)=6 pairs to choose.
// - At n=3, there are C(3,2)=3 pairs to choose.
// - At n=2, there is C(2,2)=1 pair to choose.
// The number of recursive paths is fixed (96), and the work done at each step is constant.
// Therefore, the overall complexity is constant time.
//
// Space Complexity: O(1)
// The recursion depth is fixed and very small (4 -> 3 -> 2 -> 1). The space used by
// the call stack and for storing intermediate results at each step is therefore bounded
// by a constant.
class Solution {
    /**
     * Determines if the four numbers in `cards` can be used to achieve the value 24
     * using the operations +, -, *, /.
     * This is a classic backtracking problem where we try every possible combination.
     * The strategy is:
     * 1. Pick any two numbers from the list.
     * 2. Apply all possible operations (+, -, *, /) to them.
     * 3. For each result, create a new list containing that result and the remaining numbers.
     * 4. Recursively call the function with the new, smaller list.
     * 5. If any recursive path returns true, a solution is found.
     *
     * - Parameter cards: An array of four integers.
     * - Returns: `true` if 24 can be made, otherwise `false`.
     */
    func judgePoint24(_ cards: [Int]) -> Bool {
        // Convert integers to doubles to handle non-integer results from division.
        let doubleCards = cards.map { Double($0) }
        return canMake24(from: doubleCards)
    }

    private func canMake24(from cards: [Double]) -> Bool {
        // Epsilon for comparing floating-point numbers to handle precision errors.
        let epsilon = 0.000001
        
        // Base Case: If only one number is left, check if it's 24.
        if cards.count == 1 {
            return abs(cards[0] - 24.0) < epsilon
        }
        
        // Recursive Step: Iterate through all pairs of numbers.
        for i in 0..<cards.count {
            for j in (i + 1)..<cards.count {
                // Pick two distinct numbers, n1 and n2.
                let n1 = cards[i]
                let n2 = cards[j]
                
                // Create a new list of the remaining numbers.
                var nextCards: [Double] = []
                for k in 0..<cards.count where k != i && k != j {
                    nextCards.append(cards[k])
                }
                
                // Generate all possible results from applying operations to n1 and n2.
                // Note: Addition and multiplication are commutative, so n1+n2 is enough.
                // Subtraction and division are not, so we must test both directions.
                var possibleResults: [Double] = [n1 + n2, n1 * n2, n1 - n2, n2 - n1]
                if abs(n2) > epsilon { possibleResults.append(n1 / n2) } // Check for division by zero
                if abs(n1) > epsilon { possibleResults.append(n2 / n1) } // Check for division by zero
                
                // For each result, recursively check if 24 can be made.
                for res in possibleResults {
                    if canMake24(from: nextCards + [res]) {
                        return true
                    }
                }
            }
        }
        
        // If no combination of operations and numbers yields 24, return false for this path.
        return false
    }
}