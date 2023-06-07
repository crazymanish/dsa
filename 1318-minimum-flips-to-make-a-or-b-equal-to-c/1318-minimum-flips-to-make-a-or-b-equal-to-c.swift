class Solution {
    func minFlips(_ a: Int, _ b: Int, _ c: Int) -> Int {
        var result = 0
        
        // max i is 30, since 10^9 in binary's length is 30
        for i in 0..<30 {
            let x = (a >> i) & 1
            let y = (b >> i) & 1
            let z = (c >> i) & 1
            
            if z == 1 {
                if x == 0, y == 0 {
                    result += 1
                }
            } else {
                /*
                *   a |  0  |  1  |  1
                *   b |  1  |  0  |  1
                *   c |  0  |  0  |  0
                */
                result += (x + y)
            }
        }
        
        return result
    }
}