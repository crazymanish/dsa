class Solution {
    func bitwiseComplement(_ num: Int) -> Int {
        var output: String = ""
        
        for x in String(num, radix: 2) {
            output += x == "0" ? "1" : "0"
        }
        
        return Int(output, radix: 2) ?? 0
    }
}