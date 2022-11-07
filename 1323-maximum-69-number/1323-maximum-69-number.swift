class Solution {
    func maximum69Number (_ num: Int) -> Int {
        var stack: [Int] = []
        
        var number = num
        while number > 0 {
            stack.append(number % 10)
            number /= 10
        }
        
        var result = 0
        var found = false
        while !stack.isEmpty {
            var popNumber = stack.popLast()!
            if found == false && popNumber == 6 {
                found = true
                popNumber = 9
            }
            
            result = result * 10 + popNumber
        }
        
        return result
    }
}