class Solution {
    func rangeSum(_ nums: [Int], _ n: Int, _ left: Int, _ right: Int) -> Int {
        var sums = [Int]()
        for i in 0..<nums.count {
            var sum = 0
            for j in i..<nums.count {
                sum += nums[j]
                sums.append(sum)
            }
        }
    
        sums = sums.sorted()
        
        let modulo = Int(1e9)+7
        var answer = 0
        for i in left-1...right-1 {
            answer += sums[i]
            answer %= modulo
        }
        
        return answer
    }
}