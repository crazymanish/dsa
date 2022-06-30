class Solution {
    func kthDistinct(_ arr: [String], _ k: Int) -> String {
        var hashMap: [String : Bool] = [:]
        var distinctElements: [String] = []

        for element in arr {
            if hashMap[element] == nil {
                hashMap[element] = true
                distinctElements.append(element)
            } else {
                if let index = distinctElements.firstIndex(of:element) {
                    distinctElements.remove(at: index)
                }
            }
        }

        if distinctElements.count >= k {
            return distinctElements[k-1]
        }

        return ""
    }
}
