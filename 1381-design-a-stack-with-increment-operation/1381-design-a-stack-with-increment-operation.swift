class CustomStack {
    var stack:[Int], top = 0 
    
    init(_ maxSize: Int) {
        stack = Array(repeating: 0, count: maxSize)
    }
    
    func push(_ x: Int) {
        guard top < stack.count else { return }
        
        stack[top] = x
        top += 1
    }
    
    func pop() -> Int {
        guard top > 0 else { return -1 }
        
        top -= 1
        return stack[top]
    }
    
    func increment(_ k: Int, _ val: Int) {
        for i in 0 ..< min(k, top) {
            stack[i] += val
        }
    } 
}

/**
 * Your CustomStack object will be instantiated and called as such:
 * let obj = CustomStack(maxSize)
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * obj.increment(k, val)
 */