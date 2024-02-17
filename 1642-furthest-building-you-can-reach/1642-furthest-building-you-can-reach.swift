class Solution {
    func furthestBuilding(_ heights: [Int], _ bricks: Int, _ ladders: Int) -> Int {
        func canReach(building atIndex: Int) -> Bool {
            var heap = [Int](), bricks = bricks, ladders = ladders
            
            for i in 0..<atIndex where heights[i] < heights[i+1] {
                heap.append(heights[i+1] - heights[i])
            }
            heap.sort(by: { $0 > $1 })
            
            for upHeight in heap {
                if ladders > 0 {
                    ladders -= 1
                } else if bricks >= upHeight {
                    bricks -= upHeight
                } else {
                    return false
                }
            }
            
            return true
        }
        
        var left = 0, right = heights.count-1
        while left < right {
            let center = (left + right + 1) / 2
            
            if canReach(building: center) {
                left = center
            } else {
                right = center - 1
            }
        }
        
        return left
    }
}