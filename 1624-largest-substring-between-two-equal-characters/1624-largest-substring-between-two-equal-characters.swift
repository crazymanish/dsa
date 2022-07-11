class Solution {
    func maxLengthBetweenEqualCharacters(_ string: String) -> Int {
        var hashMap: [Character : Index] = [:]

        var index = 0
        for char in string {
            if let hashMapValue = hashMap[char] {
                hashMapValue.endIndex = index
            } else {
                hashMap[char] = Index(index, -1)
            }

            index += 1
        }

        var maxLengthIndex = Index(-1, -1)

        for (_, value) in hashMap {
            maxLengthIndex = maxLength(maxLengthIndex, value)
        }

        if maxLengthIndex.endIndex == -1 { return -1 }

        return maxLengthIndex.endIndex - maxLengthIndex.startIndex - 1
    }

    private func maxLength(_ index1: Index, _ index2: Index) -> Index {
        let index1Length = index1.endIndex - index1.startIndex
        let index2Length = index2.endIndex - index2.startIndex

        if index1Length > index2Length {
            return index1
        } else {
            return index2
        }
    }
}

private class Index {
    let startIndex: Int
    var endIndex: Int

    init(_ startIndex: Int, _ endIndex: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
}
