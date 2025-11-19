/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • Building the set: O(n)
///   • Doubling loop:    O(log(finalValue / original)) → effectively O(log n)
///   • Total:            O(n)
///
/// Space Complexity:
///   • O(n) to store the set of numbers
///
/// Description:
///   Store all numbers in a set, then repeatedly double `currentValue`
///   while it exists in the set.
/// ---------------------------------------------------------------------------
class Solution {
    func findFinalValue(_ nums: [Int], _ original: Int) -> Int {
        // Store elements in a Set for O(1) membership checks
        let values = Set(nums)
        
        // Start from the original value and keep doubling it
        var currentValue = original
        
        // Continue doubling as long as the set contains the value
        while values.contains(currentValue) {
            currentValue *= 2
        }
        
        return currentValue
    }
}
