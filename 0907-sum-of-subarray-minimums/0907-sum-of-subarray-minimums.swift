class Solution {
    func sumSubarrayMins(_ arr: [Int]) -> Int {
        let stack = Stack<Int>()
        
        let n = arr.count
        
        let maxNum = 1_000_000_007
        var sum = 0
        
        var memo: [Int] = Array(repeating: 0, count: n)
        
       for i in 0..<n {
            let each = arr[i]
            while !stack.isEmpty, arr[stack.top] >= each {
                stack.pop()
            }
            
            if stack.isEmpty {
                var curr = 0
                curr += (each*(i+1))
                curr = curr%maxNum
                stack.push(i)
                memo[i] = curr
                sum += curr
                sum %= maxNum
            } else {
                var curr = 0
                let top = stack.top
                curr += (each*(i-top))
                curr = curr%maxNum
                curr += memo[top]
                curr = curr%maxNum
                stack.push(i)
                memo[i] = curr
                sum += curr
                sum %= maxNum
            }            
        }
        
        return sum
        
    }
}

class Stack<T> {
     var items: [T] = []
     
     var size: Int {
         return self.items.count
     }
    
     var isEmpty: Bool {
         return self.items.isEmpty
     }
    
     var top: T {
         return self.items.last!
     }
     
     func push(_ e: T) {
         self.items.append(e)
     }
    
     func pop() -> T {
         return self.items.removeLast()
     }
}