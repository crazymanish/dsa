class Solution {
    func beautifulSubsets(_ nums: [Int], _ k: Int) -> Int {
        let nums = nums.sorted()
        let lookup = Dictionary(grouping: zip(nums, 0...), by:\.0)
        var dp = Set([0])
        
        for i in nums.indices  {
            let target = nums[i]-k
            let candidates = lookup[target] ?? [] // = [(num,index)]
            for j in dp
              where candidates.first{(1<<$1) & j != 0} == nil {
                dp.insert(1<<i | j)
            }
        }
        
        return dp.count-1 // -1 to remove empty set
    }
}