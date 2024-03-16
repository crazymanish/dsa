class Solution {
    func findMaxLength(_ nums: [Int]) -> Int {
        let n = nums.count
        
        guard n > 1 else { return 0 }
        
        //an array to keep track of the first index of each count
        //-1 means we have not seen this count before
        var counts = Array(repeating: -1, count: 2*n + 1)
        
        //variable to keep track of the best sequence and the current count
        var ones = 0 //0 means the count of 1s and 0s is even
        var best = 0
        
        //set the index for the starting count
        counts[n] = 0
        
        //loop through the array, keeping track of the best sequence
        for currentIndex in 1...n {
            ones += nums[currentIndex-1] == 1 ? 1 : -1
            
            //get the last index when the count was ones
            let lastIndex = counts[ones+n]
            
            //if that is a real index, update best
            if lastIndex >= 0 {
                if currentIndex-lastIndex > best {
                    best = currentIndex-lastIndex
                }
            } else {
                counts[ones+n] = currentIndex
            }
        }
                
        return best
    }
}