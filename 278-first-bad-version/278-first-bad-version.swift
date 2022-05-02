/**
 * The knows API is defined in the parent class VersionControl.
 *     func isBadVersion(_ version: Int) -> Bool{}
 */

class Solution : VersionControl {
    func firstBadVersion(_ n: Int) -> Int {
        func findFirstBadVersionUsingRecursiveBinarySearch(_ startVersion: Int, _ endVersion: Int) -> Int {
            if startVersion > endVersion { return -1 } // Base case for not-found
            
            let midVersion = startVersion + (endVersion-startVersion) / 2
            let isMidVersionBad = isBadVersion(midVersion) // Using existing VersionControl API
            
            if isMidVersionBad && midVersion == 1 { return midVersion } // Found answer, First itself is Bad
            
            if isMidVersionBad {
                let previousVersion = midVersion-1
                if previousVersion > 0 && isBadVersion(previousVersion) == false { // Found answer
                    return midVersion
                } else { // Find BadVersion in left side
                    return findFirstBadVersionUsingRecursiveBinarySearch(startVersion, midVersion-1)
                }
            } else { // Find BadVersion in right side
                return findFirstBadVersionUsingRecursiveBinarySearch(midVersion+1, endVersion)
            }
        }
        
        return findFirstBadVersionUsingRecursiveBinarySearch(1, n)
    }
}