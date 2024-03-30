class Solution {
    func subarraysWithKDistinct(_ nums: [Int], _ k: Int) -> Int {  
        func subarraysWithAtMostKDistinct(_ k: Int) -> Int {
            var start = 0
            var length = 0
            var map = [Int: Int]()
        
            for (end, num) in nums.enumerated() {
                map[num] = end
            
                if map.keys.count == k+1 {
                    let delIndex = map.values.min()!
                    map[nums[delIndex]] = nil
                    start = delIndex+1
                }
            
                length += end-start 
            }
        
            return length
        }
        
        let v1 = subarraysWithAtMostKDistinct(k)
        let v2 = subarraysWithAtMostKDistinct(k-1)
        return v1 - v2 
    }
}