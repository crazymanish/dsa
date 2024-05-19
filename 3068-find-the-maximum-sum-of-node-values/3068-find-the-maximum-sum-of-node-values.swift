class Solution {
    func maximumValueSum(_ nums: [Int], _ k: Int, _ edges: [[Int]]) -> Int {
        var delta = nums.map { ($0 ^ k) - $0 }
        delta.sort(by: >)
        
        var result = nums.reduce(0, +)
        
        for i in stride(from: 0, to: nums.count, by: 2) {
            if i == nums.count - 1 { break }
            
            var totalDelta = delta[i] + delta[i + 1]
            if totalDelta <= 0 { break }
            
            result += totalDelta
        }
        
        return result
    }
}