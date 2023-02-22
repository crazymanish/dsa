class Solution {
    func shipWithinDays(_ weights: [Int], _ D: Int) -> Int {
        //first find the search space
        //the capacity must lie between max(weights) and sum(weights)
        var low = Int.min
        weights.forEach { low = max(low, $0)}
        var high = weights.reduce(0, +)
        
        //greedy approach
        func isFeasible(_ capacity: Int) -> Bool {
            var days = 1
            var total = 0
            
            for weight in weights {
                total += weight
                if total > capacity { //too heavy, wait for the next day
                    total = weight
                    days += 1
                    
                    if days > D { //can't ship within D days
                        return false
                    }
                }
            }
            
            return true
        }
        
        //now we need to do a binary search between these weights to find the best 
        //minimum weight to carry these packages in D days
        while low <= high {
            var mid = low + (high - low)/2
            if isFeasible(mid) { high = mid - 1 }
            else { low = mid + 1 }
        }
        
        return low
    }
}