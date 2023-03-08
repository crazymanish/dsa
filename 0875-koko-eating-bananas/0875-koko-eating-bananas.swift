class Solution {
    func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        if(piles.count == 0) { return 0 }
        
        func canEatBananaInTime(_ k:Int) ->Bool {
            var total = 0
            
            for pile in piles {
                total = total + pile/k
                
                if(pile%k != 0) {
                    total += 1
                }
            }
            
            return total <= h 
        }
        
        var left = 1
        var right = piles.max()!
        
        while(left <= right) {
            let mid = (left + right)/2
            
            if(canEatBananaInTime(mid)) {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        
        return left
    }
}