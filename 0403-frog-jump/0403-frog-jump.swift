class Solution {
    func canCross(_ stones: [Int]) -> Bool {
	    let stonesCount = stones.count
	    var validSteps = Array(repeating: Array(repeating: false, count: stonesCount), count: stonesCount)
	    validSteps[0][1] = true

	    for i in 1..<stonesCount {
		    for j in 0..<i {
			    let currentStep = stones[i]-stones[j]
			    if currentStep >= stonesCount || validSteps[j][currentStep] == false { continue }

			    if i == stonesCount-1 { return true }
			    
                if currentStep > 1 { 
                    validSteps[i][currentStep-1] = true 
                }
                
			    validSteps[i][currentStep] = true
			    validSteps[i][currentStep+1] = true
		    }
	    }

	    return false
    }
}