class Solution {
    func findMinDifference(_ timePoints: [String]) -> Int {
	    // Map timepoints to represent minutes since 00:00, then sort in ascending order
	    let timePoints = timePoints
		    .map(convertTimePointToMinutes)
		    .sorted()

	    // Default to 24*60 minutes as that is 1 higher than max possible difference between two times
	    var minMinuteDiff = 1440
	    var previousTimePoint = timePoints[0]

	    // Compare each time point with the previous one starting at second time point
	    for timePoint in timePoints.dropFirst() {
		    let diff = abs(timePoint - previousTimePoint)
		    minMinuteDiff = min(diff, minMinuteDiff)
		    previousTimePoint = timePoint
	    }

	    // Compare first and last time points in the sorted list
	    if let firstTimePoint = timePoints.first, let lastTimePoint = timePoints.last {
		    let diff = 1440 - abs(firstTimePoint - lastTimePoint)
		    minMinuteDiff = min(diff, minMinuteDiff)
	    }

	    return minMinuteDiff
    }
    
    // Converts time point to minute representation since 00:00
    func convertTimePointToMinutes(_ timePoint: String) -> Int {
	    (Int(timePoint.split(separator: ":")[0])! * 60) + Int(timePoint.split(separator: ":")[1])!
    }
}