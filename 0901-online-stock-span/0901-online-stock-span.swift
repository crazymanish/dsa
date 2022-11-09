class StockSpanner {
    var stack = [(price: Int, span :Int)]()
    
    init() {}
    
    func next(_ price: Int) -> Int {
        var span = 1
        
        while let last = stack.last, price >= last.price {
            span += stack.removeLast().span
        }
        
        stack.append((price, span))
        
        return span
    }
}

/**
 * Your StockSpanner object will be instantiated and called as such:
 * let obj = StockSpanner()
 * let ret_1: Int = obj.next(price)
 */