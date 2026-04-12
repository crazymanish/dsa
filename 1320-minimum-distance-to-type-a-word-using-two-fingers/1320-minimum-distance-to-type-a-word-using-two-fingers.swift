class Solution {
    /**
     Problem Summary:
     Given a word, we type it using two fingers on a 6x5 keyboard grid (A–Z).
     Each move costs Manhattan distance. We want to minimize total typing distance.

     Strategy:
     - Compute total distance assuming one finger types everything.
     - Use DP to maximize "saved distance" by optimally using the second finger.
     - dp[char] = maximum saving when second finger is currently at `char`.
     - At each step:
        1. Either continue with the same finger (no extra saving)
        2. Or switch to second finger and gain saving
     - Final answer = total distance - maximum saving.

     Time Complexity:
     O(N * 26)

     Space Complexity:
     O(26)
     */

    // Compute Manhattan distance between two characters on the keyboard
    private func distance(_ from: Character, _ to: Character) -> Int {
        let firstIndex = Int(from.asciiValue! - Character("A").asciiValue!)
        let secondIndex = Int(to.asciiValue! - Character("A").asciiValue!)

        let firstRow = firstIndex / 6
        let firstCol = firstIndex % 6

        let secondRow = secondIndex / 6
        let secondCol = secondIndex % 6

        return abs(firstRow - secondRow) + abs(firstCol - secondCol)
    }

    func minimumDistance(_ word: String) -> Int {
        let characters = Array(word)
        let n = characters.count

        // dp[charIndex] = max saving when second finger is at this character
        var dp = Array(repeating: 0, count: 26)

        var totalDistance = 0

        for i in 0..<(n - 1) {
            let currentChar = characters[i]
            let nextChar = characters[i + 1]

            let moveCost = distance(currentChar, nextChar)
            totalDistance += moveCost

            var nextDP = Array(repeating: 0, count: 26)

            for secondFingerPos in 0..<26 {
                // Case 1: Do not use second finger, carry forward state
                nextDP[secondFingerPos] = max(nextDP[secondFingerPos], dp[secondFingerPos])

                // Case 2: Use second finger to type nextChar
                let secondFingerChar = Character(UnicodeScalar(secondFingerPos + Int(Character("A").asciiValue!))!)

                let saving = dp[secondFingerPos] + moveCost - distance(secondFingerChar, nextChar)

                // Now second finger moves to currentChar position
                let currentIndex = Int(currentChar.asciiValue! - Character("A").asciiValue!)
                nextDP[currentIndex] = max(nextDP[currentIndex], saving)
            }

            dp = nextDP
        }

        // Find maximum saving achieved
        let maxSaving = dp.max() ?? 0

        return totalDistance - maxSaving
    }
}