class Solution {
    func getAverages(_ nums: [Int], _ k: Int) -> [Int] {
        let n = nums.count
        var avgs = Array(repeating: -1, count: n)
        let diameter = 2*k + 1
        
        if diameter > n { return avgs } // does not fit into array

        // sum for first suitable position
        var slidingSum = nums[0..<diameter].reduce(0, +)

        for center in k..<(n-k) {
            avgs[center] = slidingSum / diameter
            
            if center + k == n-1 { break }     // bumped into the right edge
            
            slidingSum -= nums[center - k]     // leaving the value out of the left radius range
            slidingSum += nums[center + k + 1] // new value entered the radius range from the right
        }
        
        return avgs
    }
}