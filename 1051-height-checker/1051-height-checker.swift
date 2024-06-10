class Solution {
    func heightChecker(_ heights: [Int]) -> Int {
        let sorted = heights.sorted()

        var result = 0
        for index in heights.indices {
            if heights[index] != sorted[index] {
                result += 1
            }
        }
        
        return result
    }
}