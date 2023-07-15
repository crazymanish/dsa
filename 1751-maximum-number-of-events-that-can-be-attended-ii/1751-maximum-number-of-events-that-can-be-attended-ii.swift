class Solution {
    func maxValue(_ events: [[Int]], _ k: Int) -> Int {
        if events.count == 1 { return events[0][2] }
        
        // sort by end time if tie use start time
        let events = events.sorted {
            return $0[1] == $1[1] ? $0[0] < $1[0] : $0[1] < $1[1]
        }
        
        var dp = [[0,0]]    // k-1
        var dp2 = [[0,0]]   // k
        
        func maxValueBeforeDate(_ start: Int) -> Int {
            var left = 0
            var right = dp.count-1
            var mid = 0
            var index = 0
            
            while left <= right {
                mid = left+(right-left)/2
                
                if dp[mid][0] == start {
                    index = mid-1
                    break
                } else if dp[mid][0] < start {
                    left = mid+1
                    index = mid
                } else {
                    right = mid-1
                    index = mid-1
                }
            }
            
            index = index > 0 ? index : 0
            return dp[index][1]
        }
        
        for _ in 1...k {
            for event in events {
                // Find the maximum value we can get before this event start
                let maxValue = maxValueBeforeDate(event[0])
                let newValue = event[2] + maxValue
                
                if newValue > dp2.last![1] {
                    dp2.append([event[1], newValue])
                }
            }
        
            dp = dp2
            dp2 = [[0,0]]
        }
    
        return dp.last![1]
    }
}