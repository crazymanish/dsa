class Solution {
    func minimizedMaximum(_ n: Int, _ quantities: [Int]) -> Int {
        let totalQuantities = quantities.reduce(0, +)
        
        var low = (totalQuantities + n - 1) / n
        var high = quantities.max()!
        var mid: Int
        while low < high {
            mid = (low + high) / 2
            let numberOfStores = quantities.reduce(0, { $0 + ($1 + mid - 1) / mid })
            
            if numberOfStores > n {
                low = mid + 1
            } else {
                high = mid
            }
        }
        
        return high
    }
}