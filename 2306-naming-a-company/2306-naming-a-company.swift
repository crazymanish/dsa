class Solution {
    func distinctNames(_ ideas: [String]) -> Int {
        var suffixesByFirstLetter: [Character: Set<String>] = [:]
        for idea in ideas {
            var chars = Array(idea)
            let firstChar = chars[0]
            let suffix = String(chars[1..<chars.count])
            suffixesByFirstLetter[firstChar, default: []].insert(suffix)
        }

        var distinctNames = 0

        var keys = Array(suffixesByFirstLetter.keys)
        var n = keys.count
        for i in 0..<n {
            for j in (i + 1)..<n {
                let suffixes1 = suffixesByFirstLetter[keys[i]]!
                let suffixes2 = suffixesByFirstLetter[keys[j]]!
                let uniqueSuffixes1 = suffixes1.subtracting(suffixes2).count
                let uniqueSuffixes2 = suffixes2.subtracting(suffixes1).count

                distinctNames += 2 * uniqueSuffixes1 * uniqueSuffixes2
            }
        }

        return distinctNames
    }
}