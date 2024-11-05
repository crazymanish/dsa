class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var left = 0 // Left pointer at the start of the array
        var right = height.count - 1 // Right pointer at the end of the array
        var maxArea = 0 // Variable to keep track of the maximum area found

        // Iterate while left pointer is less than right pointer
        while left < right {
            // Calculate the width between the two pointers
            let width = right - left
        
            // Determine the height of the shorter line
            let minHeight = min(height[left], height[right])
        
            // Calculate the area and compare it to the maxArea
            let area = width * minHeight
            maxArea = max(maxArea, area)
        
            // Move the pointer of the shorter line inward
            if height[left] < height[right] {
                left += 1 // Move the left pointer to the right
            } else {
                right -= 1 // Move the right pointer to the left
            }
        }
    
        return maxArea
    }
}

/*
Execution Steps
Let's break down the execution with an example input:

let heights = [1,8,6,2,5,4,8,3,7]
print(maxArea(heights)) // Should return 49
Initialize Pointers: left = 0 and right = 8 (the end of the array), maxArea = 0.

Calculate the Initial Area:
Width = right - left = 8
Minimum height between heights[left] and heights[right] = min(1, 7) = 1
Area = 8 * 1 = 8
Update maxArea to be max(0, 8) = 8
Move the Left Pointer (since height[left] < height[right]):

left = 1
Recalculate Area:

Width = right - left = 7
Minimum height = min(8, 7) = 7
Area = 7 * 7 = 49
Update maxArea to be max(8, 49) = 49
Move the Right Pointer (since height[left] > height[right]):

right = 7
Recalculate Area:

Width = right - left = 6
Minimum height = min(8, 3) = 3
Area = 6 * 3 = 18
maxArea remains 49
Continue Moving Pointers and Calculating Area:

Repeat similar calculations, always comparing areas and updating maxArea as needed.
Eventually, the loop will complete when left meets right.
Final Output
The function will return 49, the maximum area found between any two lines in the array.

Key Points
Two-Pointer Technique: Efficiently finds the maximum area by moving inward based on the height of the shorter line.
Time Complexity:O(n), since each line is checked only once.
Space Complexity:O(1), only a few extra variables are used.
This approach allows us to find the largest container in optimal time by minimizing unnecessary calculations, making it a great example of using two pointers effectively.
*/