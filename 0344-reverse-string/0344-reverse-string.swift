class Solution {
    func reverseString(_ s: inout [Character]) {
        reverseString(&s, 0, s.count-1)
    }

    private func reverseString(_ s: inout [Character], _ firstIndex: Int, _ lastIndex: Int) {
        guard s.isEmpty == false else { return }

        if firstIndex >= lastIndex { return }

        // Replace first with last.
        let temp = s[firstIndex]
        s[firstIndex] = s[lastIndex]
        s[lastIndex] = temp

        let newFirstIndex = firstIndex + 1
        let newLastIndex = lastIndex - 1
        reverseString(&s, newFirstIndex, newLastIndex)
    }
}