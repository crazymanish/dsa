class Solution {
    func average(_ salary: [Int]) -> Double {
        var maxValue = salary[0]
        var minValue = salary[0]
        var sum = 0
        
        for currentSalary in salary {
            maxValue = max(maxValue, currentSalary)
            minValue = min(minValue, currentSalary)
            sum += currentSalary
        }
        
        sum = sum - maxValue - minValue
        return Double(sum) / Double((salary.count - 2))
    }
}