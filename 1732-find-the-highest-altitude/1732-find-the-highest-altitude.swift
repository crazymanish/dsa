class Solution {
    func largestAltitude(_ gain: [Int]) -> Int {
	    var maxAltitude = 0
        var currentAltitude = 0
	    
        for altitude in gain {
		    currentAltitude += altitude
            
            maxAltitude = max(maxAltitude, currentAltitude)
	    }
        
	    return maxAltitude
    }
}