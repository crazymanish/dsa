/**
 Problem Summary:
 Determine whether Alice wins the Sum Game after all question marks are replaced
 optimally by Alice and Bob.

 Strategy:
 Treat each "?" as contributing an average value of 4.5.

 Because the string has an even length, Alice wins exactly when the effective
 sum of the left half differs from the effective sum of the right half.

 Using Double allows each "?" to be represented directly as 4.5.

 Time Complexity:
 O(n), where n is the length of `num`.

 Space Complexity:
 O(n), because the string is converted into an array of numeric values.
 */
class Solution {
    func sumGame(_ num: String) -> Bool {
        let length = num.count

        // Digits keep their numeric value.
        // A question mark is represented by the average digit value, 4.5.
        let values = num.map { character in
            character.wholeNumberValue.map(Double.init) ?? 4.5
        }

        let middleIndex = length / 2

        // Alice wins when the two halves cannot end with equal sums
        // under optimal play.
        let leftSum = values[..<middleIndex].reduce(0, +)
        let rightSum = values[middleIndex...].reduce(0, +)

        return leftSum != rightSum
    }
}