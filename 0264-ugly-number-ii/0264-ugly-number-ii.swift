class Solution {
    func nthUglyNumber(_ n: Int) -> Int {
        var index2 = 0, index3 = 0, index5 = 0
        var uglyNumbers: [Int] = []
        uglyNumbers.append(1)
        
        while uglyNumbers.count < n {
            let nextUglyNumber = min(min(uglyNumbers[index2] * 2, uglyNumbers[index3] * 3), uglyNumbers[index5] * 5)
            uglyNumbers.append(nextUglyNumber)
            
            if nextUglyNumber == uglyNumbers[index2] * 2 { index2 += 1 }
            if nextUglyNumber == uglyNumbers[index3] * 3 { index3 += 1 }
            if nextUglyNumber == uglyNumbers[index5] * 5 { index5 += 1 }
        }
        
        return uglyNumbers[n-1]
    }
}