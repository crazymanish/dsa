class Solution {
    func minimumLength(_ s: String) -> Int {
        let s = Array(s)

        var leftPointer = 0
        var rightPointer = s.count-1
        while leftPointer < rightPointer && s[leftPointer] == s[rightPointer] {
            let char = s[leftPointer]
            while leftPointer <= rightPointer && s[leftPointer] == char { leftPointer += 1 }
            while leftPointer <= rightPointer && s[rightPointer] == char { rightPointer -= 1}
        }

        return rightPointer-leftPointer+1
    }
}