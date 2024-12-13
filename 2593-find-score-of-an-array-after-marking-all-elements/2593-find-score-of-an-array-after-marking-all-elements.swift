class Solution {
    func findScore(_ nums: [Int]) -> Int {
        var sorted = zip(nums, 0...).sorted(by: <)
        var marked = Set<Int>()
        var score = 0
        
        for (num,i) in sorted where marked.contains(i) == false {
            score += num
            marked.formUnion(i-1...i+1)
            
            guard marked.count < nums.count+2 else { break }
        }
        
        return score
    }
}