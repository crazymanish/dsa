/*
Time Complexity: O(N)
The algorithm performs two passes over the input string (one for each pattern). In each pass, every character is pushed onto and popped from the stack at most once. This results in a time complexity that is linear to the length of the string, N.

Space Complexity: O(N)
A stack (character array) is used to process the string. In the worst-case scenario, the stack could hold all the characters of the input string, leading to a linear space requirement.
*/
class Solution {
    func maximumGain(_ s: String, _ x: Int, _ y: Int) -> Int {
        var totalGain = 0
        var chars = Array(s)

        // Determine which pattern has a higher score. It's always optimal to remove the
        // higher-scoring pattern first to maximize gains.
        if x > y {
            // Prioritize removing "ab"
            let (gainFromAB, remainingAfterAB) = remove(pattern: ("a", "b"), with: x, from: chars)
            let (gainFromBA, _) = remove(pattern: ("b", "a"), with: y, from: remainingAfterAB)
            totalGain = gainFromAB + gainFromBA
        } else {
            // Prioritize removing "ba"
            let (gainFromBA, remainingAfterBA) = remove(pattern: ("b", "a"), with: y, from: chars)
            let (gainFromAB, _) = remove(pattern: ("a", "b"), with: x, from: remainingAfterBA)
            totalGain = gainFromBA + gainFromAB
        }
        
        return totalGain
    }

    /// Helper function to remove all occurrences of a given pattern from a character array.
    /// - Returns: A tuple containing the total gain and the remaining characters after removal.
    private func remove(pattern: (Character, Character), with gain: Int, from chars: [Character]) -> (gain: Int, remaining: [Character]) {
        var currentGain = 0
        var stack: [Character] = []
        
        for char in chars {
            // Check if the current character completes the pattern with the top of the stack.
            if char == pattern.1 && stack.last == pattern.0 {
                // Pattern found, pop from stack and add gain.
                stack.removeLast()
                currentGain += gain
            } else {
                // No pattern found, just push the character onto the stack.
                stack.append(char)
            }
        }
        
        return (currentGain, stack)
    }
}