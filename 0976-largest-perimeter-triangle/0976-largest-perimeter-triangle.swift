// Time Complexity: O(N log N)
// Sorting the array is the most time-consuming step, taking O(N log N). The subsequent
// linear scan through the array takes O(N), which is dominated by the sort.
//
// Space Complexity: O(N)
// In Swift, `sorted()` creates a new sorted copy of the array, requiring O(N) space. If
// the sort were done in-place, the space complexity would be O(log N) or O(1).
class Solution {
    func largestPerimeter(_ nums: [Int]) -> Int {
        // Sort the numbers to easily apply the Triangle Inequality Theorem.
        let numbers = nums.sorted()
        var maxPerimeter = 0
        
        // Iterate through the array, considering every window of three consecutive numbers.
        // We stop at the second-to-last element to ensure there's always a triplet to check.
        for index in 1..<numbers.count-1 {
            // Check the triangle inequality for the triplet:
            // numbers[index-1], numbers[index], numbers[index+1]
            // Since the array is sorted, we only need to check if the sum of the two smaller
            // sides is greater than the largest side.
            if numbers[index-1] + numbers[index] > numbers[index+1] {
                // If it's a valid triangle, calculate its perimeter.
                let sum = numbers[index-1] + numbers[index] + numbers[index+1]
                // Update the result if this triangle's perimeter is the largest found so far.
                maxPerimeter = max(maxPerimeter, sum)
            }
        } 
        
        return maxPerimeter
    }
}