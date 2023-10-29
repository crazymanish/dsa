class Solution {
    func poorPigs(_ buckets: Int, _ minutesToDie: Int, _ minutesToTest: Int) -> Int {
        let n = minutesToTest/minutesToDie + 1
        var result = 0.0
        
        while pow(Double(n), result) < Double(buckets){
            result += 1.0
        }
        
        return Int(result)
    }
}