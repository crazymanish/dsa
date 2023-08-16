class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        var result = [Int]()
        var queue = [Int]()
        var lhs = 0 //second pointer
        
        for index in 0..<nums.count {
            while (!queue.isEmpty && nums[index] > queue.last!) {
                // Complexity: O(1) // same as dropLast element
                queue.popLast()
            }
            queue.append(nums[index]) // append the current index value to queue
            
            if index >= (k-1) { // use k-1 //because array is zero index
                result.append(queue.first!) // append the first value from queue
                
                if (nums[lhs] == queue.first) {
                    // Complexity: O(1) // because  `dropFirst` input = 1 
                    // remove the first value from the queue
                    queue = Array(queue.dropFirst(1))
                }
                lhs += 1 // increase the second pointer = slide by one 
            } 
        }
        
        return result
    }
}