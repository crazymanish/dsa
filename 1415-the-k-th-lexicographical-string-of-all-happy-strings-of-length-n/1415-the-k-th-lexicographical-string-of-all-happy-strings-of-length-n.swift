class Solution {
    func getHappyString(_ n: Int, _ k: Int) -> String {
        let characters: [Character] = ["a", "b", "c"]

        var happyStringCount = 0
        var lastHappyString = ""
        var currentHappyString = ""

        func generateHappyString(currentIndex: Int) {
            if happyStringCount == k { return } // Early termination

            if currentIndex == n {
                happyStringCount += 1
                lastHappyString = currentHappyString
                return
            }

            for char in characters {
                // Avoid force-unwrap with optional binding
                if let lastChar = currentHappyString.last, lastChar == char { continue } 
                currentHappyString.append(char)
                generateHappyString(currentIndex: currentIndex + 1)
                currentHappyString.removeLast() // Backtracking
            }
        }

        generateHappyString(currentIndex: 0)
        return happyStringCount == k ? lastHappyString : ""
    }
}