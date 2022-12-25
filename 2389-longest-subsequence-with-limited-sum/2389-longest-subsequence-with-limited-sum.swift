class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let runningSum = nums.sorted().reduce(into: [Int]()) { $0.append(($0.last ?? 0) + $1)}
        var result = [Int](repeating: 0, count: queries.count)
        
        func binarySearch(_ query: Int) -> Int {
            var left = 0
            var right = runningSum.count - 1
            
            while left <= right {
                let mid = left + (right - left) / 2
                if runningSum[mid] <= query {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
            
            return left
        }
        
        for (i, query) in queries.enumerated() {
            result[i] = binarySearch(query)
        }
        
        return result
    }
}