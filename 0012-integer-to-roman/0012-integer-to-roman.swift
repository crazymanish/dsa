class Solution {
    func intToRoman(_ num: Int) -> String {
        let keys = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let values = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        var hashMap: [Int : String] = [:]
        
        for index in 0..<keys.count {
            hashMap[keys[index]] = values[index]
        }
        
        var output = ""
        var mutableNum = num
        while mutableNum > 0 {
            for intNumber in keys {
                let division = mutableNum / intNumber
                if division > 0 {
                    for _ in 0..<division {
                        output += hashMap[intNumber]!
                        mutableNum -= intNumber
                    }
                }
            }
        }
        
        return output
    }
}