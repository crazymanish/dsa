class Solution {
    func areSentencesSimilar(_ sentence1: String, _ sentence2: String) -> Bool {
        let words1 = sentence1.split(separator: " ")
        let words2 = sentence2.split(separator: " ")

        let (shorter, longer) = words1.count < words2.count ? (words1, words2) : (words2, words1)

        var start = 0
        while start < shorter.count && shorter[start] == longer[start] {
            start += 1
        }

        var end = 0
        while end < shorter.count - start && shorter[shorter.count - 1 - end] == longer[longer.count - 1 - end] {
            end += 1
        }

        return start + end == shorter.count
    }
}