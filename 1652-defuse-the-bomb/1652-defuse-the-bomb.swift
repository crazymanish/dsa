class Solution {
    func decrypt(_ code: [Int], _ k: Int) -> [Int] {
        var output = Array(repeating: 0, count: code.count)
        
        if k == 0 { return output }
        
        for i in 0..<code.count {
            let goprev = k < 0
            var currentSum = 0
            
            for j in 1...abs(k) {
                currentSum += (goprev ? code[code.prevIndex(i-j)] : code[code.nextIndex(j+i)])
            }
            
            output[i] = currentSum
        }
        
        return output
    }
}

extension Array {
    func nextIndex(_ index: Int) -> Int {
        return index % count
    }
    
    func prevIndex(_ index: Int) -> Int {
        if index < 0 { return count + index }
        
        return index
    }
}