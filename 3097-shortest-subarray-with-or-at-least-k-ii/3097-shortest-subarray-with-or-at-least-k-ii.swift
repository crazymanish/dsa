class Solution {
    func minimumSubarrayLength(_ nums: [Int], _ k: Int) -> Int {
        guard nums.reduce(0,|) >= k else { return -1 }
        
        let maxBits = 30 // minimum number of bits to represent max value of `k` (10^9)

        func subarrayExists(_ count: Int) -> Bool {
            var bitSums = Array(repeating:0, count: maxBits)
            var bits = 0 // bitwise-OR of all non-zero `bitSums` elements
            
            for i in nums.indices {
                var p = nums[i] // add these bits
                var q = i>=count ? nums[i-count] : 0 // remove these bits
                for bit in 0..<maxBits {
                    guard p+q > 0 else { break }
                    bitSums[bit] += p&1-q&1
                    bits = bitSums[bit]>0 ? (bits | 1<<bit) : (bits & ~(1<<bit))
                    p >>= 1
                    q >>= 1
                }
                
                guard bits < k else { return true }
            }
            
            return false
        }
        
        var (l,r) = (1,nums.count) 
        while l<r {
            let mid = (l+r)/2 //`mid` is subarray window length
            (l,r) = subarrayExists(mid) ? (l,mid) : (mid+1,r)
        }
        
        return l
    }
}