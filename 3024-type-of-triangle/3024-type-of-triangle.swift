class Solution {
    /// Determines the type of a triangle given an array of three side lengths.
    ///
    /// - Parameter nums: An array of three integers representing the lengths of the sides of a potential triangle.
    ///                   It's assumed `nums` will always contain exactly three positive integers as per typical problem constraints.
    /// - Returns: A string indicating the type of triangle: "equilateral", "isosceles", "scalene", or "none"
    ///            if the sides cannot form a valid triangle.
    ///
    /// --- Time and Space Complexity ---
    /// - Time Complexity: O(1)
    ///   The function performs sorting on 3 elements (constant time), followed by a fixed number of
    ///   comparisons and arithmetic operations.
    ///
    /// - Space Complexity: O(1)
    ///   The function uses a constant amount of extra space (for the sorted array if not in-place,
    ///   or for variables). If `nums` is modified in-place, space is minimal.
    ///   `nums.sorted()` creates a new array, but it's of fixed size 3.
    func triangleType(_ nums: [Int]) -> String {
        // Sort the sides to simplify comparisons.
        // For 3 elements, sorting is a constant time operation.
        let sides = nums.sorted()
        let sideA = sides[0] // Smallest side
        let sideB = sides[1] // Middle side
        let sideC = sides[2] // Largest side

        // --- Step 1: Check for Triangle Inequality Theorem ---
        // For a sorted array (sideA <= sideB <= sideC), the triangle inequality theorem
        // (sum of any two sides > third side) simplifies to:
        // sideA + sideB > sideC.
        // The other two conditions (sideA + sideC > sideB and sideB + sideC > sideA)
        // will automatically hold if sideA + sideB > sideC and sides are positive.
        // The problem statement assumes positive integers.
        if sideA + sideB > sideC {
            // --- Step 2: Classify the type of triangle if it's valid ---

            // Check for equilateral: all three sides are equal.
            // If sorted, this means the smallest (sideA) equals the largest (sideC).
            if sideA == sideC { // This implies sideA == sideB == sideC
                return "equilateral"
            }
            // Check for isosceles: at least two sides are equal.
            // If it's not equilateral, we check if any two sides are equal.
            // Given sideA <= sideB <= sideC:
            // - sideA == sideB (smallest two are equal)
            // - OR sideB == sideC (largest two are equal)
            else if sideA == sideB || sideB == sideC {
                return "isosceles"
            }
            // Check for scalene: all three sides are of different lengths.
            // If it's a valid triangle and not equilateral or isosceles, it must be scalene.
            else {
                return "scalene"
            }
        }
        // --- Step 3: If the sides cannot form a triangle ---
        else {
            return "none"
        }
    }
}
