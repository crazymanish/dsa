class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        let aMap = a.map { String($0) }
        let bMap = b.map { String($0) }
        
        var i = aMap.count - 1
        var j = bMap.count - 1
        var carry = 0
        var outputToReverse = [String]()
        
        while i >= 0 || j >= 0 {
            let aInt = i >= 0 ? Int(aMap[i])! : 0
            let bInt = j >= 0 ? Int(bMap[j])! : 0
            
            let integerResult = aInt + bInt + carry // possible results: 0, 1, 2, 3
            let binaryResult = integerResult % 2 // possible results: 0, 1
            
            let binaryStringResult = String(binaryResult)
            outputToReverse.append(binaryStringResult)
            
            carry = integerResult >= 2 ? 1 : 0
            i -= 1
            j -= 1
        }
        
        // take care of any remaining carry
        if carry == 1 { outputToReverse.append("1") }
        
        return outputToReverse.reversed().joined()
    }
}