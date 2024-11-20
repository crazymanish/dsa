class Solution {
    func takeCharacters(_ s: String, _ k: Int) -> Int {
        let s = s.utf8.map{ascii in Int(ascii-97)} // 97 is ASCII a
        var counts = s.reduce(into: [-k,-k,-k]) {arr, i in arr[i] += 1}
        
        guard counts.min()! >= 0 else { return -1 }
        
        var left = 0
        var maxWindow = 0

        for right in s.indices {
            counts[s[right]] -= 1
            
            while counts.min()! < 0 {
                counts[s[left]] += 1
                left += 1
            }
            
            maxWindow = max(maxWindow, right-left+1)
        }

        return s.count - maxWindow
    }
}

/*
Plan:
Count Total Characters: Count the occurrences of 'a', 'b', and 'c' in the entire string to ensure you have at least 2 * k of each character. If not, return -1.

Sliding Window Technique: Use a sliding window to find the smallest substring that can be removed so the remaining part of the string has at least k of each character on both ends.

Maintain Character Counts: Keep track of the counts of 'a', 'b', and 'c' in the substring and dynamically adjust the counts when expanding or shrinking the window.

Calculate Minimum Length: Iterate through the string and calculate the minimum length of the removable substring.

Step-by-Step Execution:
Input:
takeCharacters("aabaaaacaabc", 2)

Step 1: Count Characters
Total counts are:
'a': 7
'b': 2
'c': 3

Step 2: Check Feasibility
Since all counts are greater than or equal to 2 * k = 4, proceed.

Step 3: Sliding Window
Initialize minLength = 12 (length of the string), left = 0, and currentCount = [0, 0, 0].
Expand right pointer to include characters in the window and adjust currentCount.

Step 4: Shrinking the Window
Shrink the window from the left when conditions are met, and update minLength:
At right = 5, the window is "aabaaa". Counts [4, 1, 0].
Shrink to "aabaa" → Update minLength = 6.

Repeat until the smallest removable substring is found.

Result:
Minimum removable substring length is 3.

Complexity:
Time Complexity: O(n), as we traverse the string with a sliding window.
Space Complexity: O(1), only using fixed arrays for counts.

This approach efficiently calculates the desired result by combining counting and sliding window techniques.
*/