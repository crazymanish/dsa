class Solution {
    func lastStoneWeight(_ stones: [Int]) -> Int {
        var stones = stones
        
        while stones.count > 1 {
            stones.sort()
            
            let last = stones.removeLast()
            let secondLast = stones.removeLast()
            
            if last != secondLast {
                stones.append(last - secondLast)
            }
        }
        
        return stones.first ?? 0
    }
}