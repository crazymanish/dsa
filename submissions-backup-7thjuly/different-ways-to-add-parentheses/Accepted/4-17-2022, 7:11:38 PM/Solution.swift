// https://leetcode.com/problems/different-ways-to-add-parentheses

class Solution {
    private var dpCacheHashMap: [String : [Int]] = [:]

    func diffWaysToCompute(_ input: String) -> [Int] {
        var output: [Int] = []

        for (index, char) in input.enumerated() {
            if char == "+" || char == "-" || char == "*" {
                let leftEndIndex = input.index(input.startIndex, offsetBy: index)
                let rightStartIndex = input.index(input.startIndex, offsetBy: index+1)
                let leftString = String(input.prefix(upTo: leftEndIndex))
                let rightString = String(input.suffix(from: rightStartIndex))

                let leftResults = dpCacheHashMap[leftString] ?? diffWaysToCompute(leftString)
                let rightResults = dpCacheHashMap[rightString] ?? diffWaysToCompute(rightString)

                for leftResult in leftResults {
                    for rightResult in rightResults {
                        if char == "+" { output.append(leftResult + rightResult) }
                        if char == "-" { output.append(leftResult - rightResult) }
                        if char == "*" { output.append(leftResult * rightResult) }
                    }
                }
            }
        }

        if output.count == 0 { output.append(Int(input)!) }

        dpCacheHashMap[input] = output // Update cache

        return output
    }
}
