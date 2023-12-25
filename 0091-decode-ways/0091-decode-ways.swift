class Solution {
    func numDecodings(_ s: String) -> Int {
        let sCount = s.count
        let hashMap = ["1": "A","2": "B","3": "C","4": "D","5": "E","6": "F","7": "G","8": "H","9": "I","10": "J","11": "K","12": "L","13": "M","14": "N","15": "O","16": "P","17": "Q","18": "R","19": "S","20": "T","21": "U","22": "V","23": "W","24": "X","25": "Y","26": "Z"]
        var dpCache = Array(repeating: -1, count: sCount+1)

        func numDecodings(_ sArray: [Character], _ count: Int, _ dpCache: inout [Int]) -> Int {
            if count == 0 {
                dpCache[count] = 1
                return 1
            }

            if dpCache[count] != -1 { return dpCache[count] }

            var output = 0

            if sArray[count-1] != "0" {
                output += numDecodings(sArray, count-1, &dpCache)
            }

            if count > 1 {
                let lastTwoNumsString = String(sArray[count-2])+String(sArray[count-1])
                if hashMap[lastTwoNumsString] != nil {
                    output += numDecodings(sArray, count-2, &dpCache)
                }
            }

            dpCache[count] = output
            return output
        }

        return numDecodings(Array(s), sCount, &dpCache)
    }
}