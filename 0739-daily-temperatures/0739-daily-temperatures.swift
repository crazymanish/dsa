class Solution {
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: temperatures.count)
        var stack: [Int] = []
        var index = 0
        
        while index < temperatures.count {
            while stack.isEmpty == false && temperatures[stack.last!] < temperatures[index] {
                let previousDay = stack.last!
                result[previousDay] = index - previousDay
                stack.removeLast()
            }
            
            stack.append(index)
            index += 1
        }
        
        return result
    }
}