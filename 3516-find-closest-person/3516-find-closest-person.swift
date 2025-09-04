// Time Complexity: O(1)
// The function performs a fixed number of basic arithmetic operations (subtraction,
// absolute value) and comparisons. The execution time is constant and does not
// depend on the magnitude of the input integers.
//
// Space Complexity: O(1)
// The function uses a few variables to store intermediate results, but the amount
// of space required is constant and does not scale with the input.
class Solution {
    /**
     * Determines which of the two integers, `x` or `y`, is closer to a third integer, `z`.
     *
     * The function calculates the absolute distance from `x` to `z` and from `y` to `z`
     * and compares them.
     *
     * - Parameters:
     * - x: The first integer.
     * - y: The second integer.
     * - z: The integer to compare distances against.
     *
     * - Returns:
     * - `1` if `x` is closer to `z`.
     * - `2` if `y` is closer to `z`.
     * - `0` if `x` and `y` are equidistant from `z`.
     */
    func findClosest(_ x: Int, _ y: Int, _ z: Int) -> Int {
        // Calculate the absolute distance between z and x.
        let distanceToX = abs(z - x)
        
        // Calculate the absolute distance between z and y.
        let distanceToY = abs(z - y)
        
        // Compare the distances to determine the result.
        if distanceToX < distanceToY {
            // x is closer to z.
            return 1
        } else if distanceToY < distanceToX {
            // y is closer to z.
            return 2
        } else {
            // The distances are equal.
            return 0
        }
    }
}