class Solution {
    func minCost(_ n: Int, _ cuts: [Int]) -> Int {
        var dpCache: [String: Int] = [:]
        
		func findMinimumCost(_ left:Int, _ right:Int) -> Int {
            let key = "\(left)-\(right)"
		    if dpCache[key] != nil { return dpCache[key]! }
		    
            var minimumCost = Int.max        
		    
            for mid in 0..<cuts.count {
			    if cuts[mid] <= left || cuts[mid] >= right { continue }
                
			    let cost = right-left
                let currentCost = findMinimumCost(left, cuts[mid]) + cost + findMinimumCost(cuts[mid], right)
                
			    minimumCost = min(minimumCost, currentCost)
		    }

		    minimumCost = minimumCost == Int.max ? 0 : minimumCost
            
            dpCache[key] = minimumCost
            return minimumCost
	    }
        
		return findMinimumCost(0, n)
	}
}