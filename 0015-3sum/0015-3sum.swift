class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = [] // Array to hold all unique triplets
        let sortedNums = nums.sorted() // Step 1: Sort the array
    
        for i in 0..<sortedNums.count {
            // Step 2: If the current number is the same as the previous one, skip to avoid duplicates
            if i > 0 && sortedNums[i] == sortedNums[i-1] { continue }
        
            let target = -sortedNums[i] // The target sum we need from the two-pointer pair
            var left = i+1
            var right = sortedNums.count-1
        
            // Step 3: Use two-pointer approach
            while left < right {
                let sum = sortedNums[left] + sortedNums[right]
            
                if sum == target {
                    result.append([sortedNums[i], sortedNums[left], sortedNums[right]])
                
                    // Move both pointers to avoid duplicates
                    left += 1
                    right -= 1
                
                    // Skip duplicates for the left pointer
                    while left < right && sortedNums[left] == sortedNums[left-1] {
                        left += 1
                    }
                
                    // Skip duplicates for the right pointer
                    while left < right && sortedNums[right] == sortedNums[right+1] {
                        right -= 1
                    }
                
                } else if sum < target {
                    left += 1 // Move the left pointer right to increase sum
                } else {
                    right -= 1 // Move the right pointer left to decrease sum
                }
            }
        }
    
        return result
    }
}

/*
Step-by-Step Execution
Sort the Array:

Input: [-1, 0, 1, 2, -1, -4]
Sorted Array: [-4, -1, -1, 0, 1, 2]
Loop through Each Element:

We iterate through the array to pick each element as the potential first element of a triplet.
First Iteration (i = 0, element = -4):

Target = -(-4) = 4
Initialize two pointers: left = 1, right = 5
Two-pointer Search:

Calculate sum = sortedNums[left] + sortedNums[right] = -1 + 2 = 1
Since 1 < 4, move left pointer right: left = 2
Calculate sum = sortedNums[left] + sortedNums[right] = -1 + 2 = 1
Move left again: left = 3
Calculate sum = sortedNums[left] + sortedNums[right] = 0 + 2 = 2
Move left again: left = 4
Calculate sum = sortedNums[left] + sortedNums[right] = 1 + 2 = 3
No triplet found in this iteration.
Second Iteration (i = 1, element = -1):

Target = -(-1) = 1
left = 2, right = 5
Two-pointer Search:

Calculate sum = sortedNums[left] + sortedNums[right] = -1 + 2 = 1
Found Triplet: [-1, -1, 2]
Move left to skip duplicates: left = 3
Move right to skip duplicates: right = 4
Calculate sum = sortedNums[left] + sortedNums[right] = 0 + 1 = 1
Found Triplet: [-1, 0, 1]
Subsequent Iterations:

The process continues, but no new unique triplets are found.
Final Result:

The function returns [[−1, −1, 2], [−1, 0, 1]].
Explanation of Key Parts
- Sorting: Sorting helps avoid duplicates and makes it easier to use the two-pointer technique.
- Skipping Duplicates: After finding a triplet, we move pointers to skip duplicate elements, ensuring unique triplets.
- Two-pointer Technique: Efficiently finds two values that sum to a target, which complements the current element to zero.

This solution has a time complexity of O(n2) due to the outer loop and two-pointer scan, and a space complexity of O(1) (ignoring the output).
*/