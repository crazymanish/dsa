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