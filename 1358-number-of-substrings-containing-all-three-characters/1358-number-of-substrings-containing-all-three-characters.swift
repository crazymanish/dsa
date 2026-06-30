class Solution {
    /**
     Problem Summary:
     Count the number of substrings that contain at least one occurrence of
     each character: "a", "b", and "c".

     Strategy:
     Use a sliding window. Expand the right side of the window one character
     at a time. Whenever the window contains all three required characters,
     shrink it from the left until it no longer does. At that point, every
     substring ending at the current right index and starting before `left`
     is valid.

     Time Complexity: O(n)
     Space Complexity: O(n) because the String is converted to an Array
     */
    func numberOfSubstrings(_ s: String) -> Int {
        let characters = Array(s)

        var left = 0
        var right = 0
        var characterCounts: [Character: Int] = [
            "a": 0,
            "b": 0,
            "c": 0
        ]

        var validSubstringCount = 0

        while right < characters.count {
            let rightCharacter = characters[right]
            characterCounts[rightCharacter, default: 0] += 1

            // Move `left` forward while the current window still contains
            // at least one "a", one "b", and one "c".
            while characterCounts["a", default: 0] > 0 &&
                  characterCounts["b", default: 0] > 0 &&
                  characterCounts["c", default: 0] > 0 {
                let leftCharacter = characters[left]
                characterCounts[leftCharacter, default: 0] -= 1
                left += 1
            }

            // All substrings ending at `right` and starting before `left`
            // contain all three required characters.
            validSubstringCount += left
            right += 1
        }

        return validSubstringCount
    }
}