class Solution {
    func compareVersion(_ version1: String, _ version2: String) -> Int {
        let versions1 = version1.components(separatedBy: ".").map { Int($0)! }
        let versions2 = version2.components(separatedBy: ".").map { Int($0)! }

        let length = max(versions1.count, versions2.count)
        
        for i in 0..<length {
            let versions1 = versions1[i, default: 0]
            let versions2 = versions2[i, default: 0]

            if versions1 != versions2 {
                return versions1 > versions2 ? 1 : -1
            }
        }
        
        return 0
    }
}

extension Array {
    subscript (_ index: Index, default element: Element) -> Element {
        index >= startIndex && index < endIndex ? self[index] : element
    }
}