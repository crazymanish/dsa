class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var charIndexMap = [Character: Int]()  // Maps characters to their most recent index
        var maxLength = 0                      // Tracks the maximum length of substring
        var start = 0                          // Left boundary of the sliding window

        for (index, char) in s.enumerated() {
            // If the character is already in the map and within the current window, adjust the window's start
            if let prevIndex = charIndexMap[char], prevIndex >= start {
                start = prevIndex + 1
            }

            // Update the character's index in the map
            charIndexMap[char] = index

            // Calculate the current window length and update the max length if needed
            maxLength = max(maxLength, index - start + 1)
        }

        return maxLength
    }
}

/*
Step-by-Step Execution

Example Input:
let s = "abcabcbb"

Initialization:
charIndexMap = [:]: A dictionary to store the most recent index of each character.
maxLength = 0: To track the longest substring length.
start = 0: The starting index of the current window.

Iteration Through s:

Index = 0, Char = 'a':
'a' is not in charIndexMap, so no adjustment to start.
Add 'a' to charIndexMap with index 0: charIndexMap = ["a": 0].
Update maxLength = max(0, 0 - 0 + 1) = 1.

Index = 1, Char = 'b':
'b' is not in charIndexMap, so no adjustment to start.
Add 'b' to charIndexMap with index 1: charIndexMap = ["a": 0, "b": 1].
Update maxLength = max(1, 1 - 0 + 1) = 2.

Index = 2, Char = 'c':
'c' is not in charIndexMap, so no adjustment to start.
Add 'c' to charIndexMap with index 2: charIndexMap = ["a": 0, "b": 1, "c": 2].
Update maxLength = max(2, 2 - 0 + 1) = 3.

Index = 3, Char = 'a':
'a' is in charIndexMap at index 0, which is >= start. Adjust start to 0 + 1 = 1.
Update 'a' in charIndexMap with index 3: charIndexMap = ["a": 3, "b": 1, "c": 2].
Update maxLength = max(3, 3 - 1 + 1) = 3.

Index = 4, Char = 'b':
'b' is in charIndexMap at index 1, which is >= start. Adjust start to 1 + 1 = 2.
Update 'b' in charIndexMap with index 4: charIndexMap = ["a": 3, "b": 4, "c": 2].
Update maxLength = max(3, 4 - 2 + 1) = 3.

Index = 5, Char = 'c':
'c' is in charIndexMap at index 2, which is >= start. Adjust start to 2 + 1 = 3.
Update 'c' in charIndexMap with index 5: charIndexMap = ["a": 3, "b": 4, "c": 5].
Update maxLength = max(3, 5 - 3 + 1) = 3.

Index = 6, Char = 'b':
'b' is in charIndexMap at index 4, which is >= start. Adjust start to 4 + 1 = 5.
Update 'b' in charIndexMap with index 6: charIndexMap = ["a": 3, "b": 6, "c": 5].
Update maxLength = max(3, 6 - 5 + 1) = 2.

Index = 7, Char = 'b':
'b' is in charIndexMap at index 6, which is >= start. Adjust start to 6 + 1 = 7.
Update 'b' in charIndexMap with index 7: charIndexMap = ["a": 3, "b": 7, "c": 5].
Update maxLength = max(3, 7 - 7 + 1) = 1.

Final Result:
maxLength = 3, as the longest substring without repeating characters is "abc".

Complexity:
Time Complexity: O(n), where n is the length of the string. Each character is processed at most twice (once when expanding the window, once when adjusting start).
Space Complexity: O(k), where k is the size of the character set (e.g., 26 for lowercase English letters).

This approach is both efficient and easy to implement for the problem.
*/