class Solution {
    func minBitFlips(_ start: Int, _ goal: Int) -> Int {
        func countBits(_ num: Int) -> Int {
            var num = num
            var count = 0
            
            while num > 0 {
                count += 1
                num = num & (num - 1)
            }
            return count
        }
        
        return countBits(start ^ goal)
    }
}