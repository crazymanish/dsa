class Solution {
    func poorPigs(_ buckets: Int, _ minutesToDie: Int, _ minutesToTest: Int) -> Int {
        let states = minutesToTest / minutesToDie + 1
        let logBuckets = log(Double(buckets))
        let logStates = log(Double(states))
        
        return Int(ceil(logBuckets / logStates))
    }
}