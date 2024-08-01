class Solution {
    func countSeniors(_ details: [String]) -> Int {
        var countSeniors = 0

        for detail in details {
            let startIndex = detail.index(detail.startIndex, offsetBy: 11)
            let endIndex = detail.index(detail.endIndex, offsetBy: -2)
            let yearRange = detail[startIndex..<endIndex]

            Int(yearRange)! > 60 ? countSeniors += 1 : nil
        }
        
        return countSeniors
    }
}