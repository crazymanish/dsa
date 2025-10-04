// Time Complexity: O(N)
// The two pointers, `left` and `right`, make a single pass through the array. In each
// iteration, either the left pointer moves right or the right pointer moves left,
// meaning each element is considered at most once.
//
// Space Complexity: O(1)
// The algorithm uses a fixed number of variables, so the space required is constant
// and does not depend on the input size.
class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var left = 0                 // Left pointer starts at the beginning.
        var right = height.count - 1 // Right pointer starts at the end.
        var maxArea = 0              // Tracks the maximum area found so far.

        // Loop until the two pointers meet.
        while left < right {
            // The area of the container is determined by the width between the lines
            // and limited by the height of the shorter line.
            let width = right - left
            let minHeight = min(height[left], height[right])
            let currentArea = width * minHeight
            
            // Update the maximum area if the current area is larger.
            maxArea = max(maxArea, currentArea)
            
            // **Core Logic:** To find a potentially larger area, we must increase the height,
            // as the width will only decrease as we move the pointers inward. By moving the
            // pointer of the shorter line, we discard the limiting factor and create an
            // opportunity to find a taller line, which might result in a larger area.
            if height[left] < height[right] {
                left += 1  // The left line is shorter, so move it to the right.
            } else {
                right -= 1 // The right line is shorter or equal, so move it to the left.
            }
        }
        
        return maxArea
    }
}