class Solution {
    func minTaps(_ n: Int, _ ranges: [Int]) -> Int {
        var index = 0 
        var start = 0
        var end = 0
        var minimumTaps = 0
        
        while end < n {
            for i in 0..<ranges.count {
                if i - ranges[i] <= start && i + ranges[i] > end {
                    end = i + ranges[i]       
                    index = i
                }                
            }
            
            if start == end {
                return -1
            }
            
            start = end
            minimumTaps += 1
        }
        
        return minimumTaps
    }
}