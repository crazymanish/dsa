class Solution {
    func gcdOfStrings(_ str1: String, _ str2: String) -> String {
        if str1 + str2 != str2 + str1 { return "" }
        
        func gcd(_ x: Int, _ y: Int) -> Int {
            if x == 0 { return y }
            
            return gcd(y % x, x)
        }
        
        let gcdOfString = Array(str1)[..<gcd(str1.count, str2.count)]
        return String(gcdOfString)
    }
}