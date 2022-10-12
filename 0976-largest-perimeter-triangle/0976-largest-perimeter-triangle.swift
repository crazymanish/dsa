class Solution {
    func largestPerimeter(_ nums: [Int]) -> Int {
        let numbers = nums.sorted()
        var maxPerimeter = 0
        
        for index in 1..<numbers.count-1 {
            if numbers[index-1] + numbers[index] > numbers[index+1] {
                let sum = numbers[index-1] + numbers[index] + numbers[index+1]
                maxPerimeter=max(maxPerimeter,sum)
            }
            
        } 
        
        return maxPerimeter
    }
}