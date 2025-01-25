class Solution {
    func lexicographicallySmallestArray(_ nums: [Int], _ limit: Int) -> [Int] {
        // Sort the input array to process elements in ascending order
        let sorted = nums.sorted()
        
        // Dictionary to map each number to its group
        var numToGroup: [Int: Int] = [:]
        
        // Initialize the first group
        var group = 0
        numToGroup[sorted[0]] = group
        
        // Array of groups, each group is a list of numbers
        var groups: [[Int]] = [[sorted[0]]]
        
        // Iterate through the sorted array to form groups
        for i in 1..<sorted.count {
            // If the difference between consecutive elements is greater than limit, start a new group
            if abs(sorted[i] - sorted[i - 1]) > limit {
                group += 1
            }
            // Map the current number to its group
            numToGroup[sorted[i]] = group
            
            // If the current group does not exist in the groups array, add it
            if group == groups.count {
                groups.append([])
            }
            // Add the current number to its group
            groups[group].append(sorted[i])
        }
        
        // Array to keep track of the current index in each group
        var groupIndex = Array(repeating: 0, count: groups.count)
        
        // Iterate through the original array to construct the result
        var nums = nums
        for i in 0..<nums.count {
            // Get the group of the current number
            let group = numToGroup[nums[i]]!
            
            // Get the current index in the group
            let index = groupIndex[group]
            
            // Increment the index for the next element in the group
            groupIndex[group] += 1
            
            // Replace the current number with the smallest available number in its group
            nums[i] = groups[group][index]
        }
        
        // Return the lexicographically smallest array
        return nums
    }
}