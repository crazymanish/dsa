final class Solution {
    /**
     Problem Summary:
     Calculate the minimum number of key presses needed to type a word
     using a keypad with 8 keys.

     Strategy:
     Characters are assigned to keypad positions in groups of 8:
     - Positions 0...7 require 1 push.
     - Positions 8...15 require 2 pushes.
     - Positions 16...23 require 3 pushes.
     
     For each character at index `i`, its push cost is `(i / 8) + 1`.

     Time Complexity: O(n)
     Space Complexity: O(1)
     */
    func minimumPushes(_ word: String) -> Int {
        var totalPushes = 0

        for index in 0..<word.count {
            // Every group of 8 characters increases the push cost by one.
            totalPushes += (index / 8) + 1
        }

        return totalPushes
    }
}