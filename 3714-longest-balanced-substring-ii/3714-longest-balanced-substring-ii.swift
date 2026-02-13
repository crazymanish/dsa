class Solution {

    /// Represents one of the 7 balance patterns we track.
    private enum KeyKind: Int {
        case abc = 0  // a-b and a-c equal => a=b=c
        case ab       // a-b equal and c unchanged => a=b and no 'c' in substring
        case bc       // b-c equal and a unchanged => b=c and no 'a'
        case ca       // c-a equal and b unchanged => c=a and no 'b'
        case onlyA    // b and c unchanged => substring has only 'a'
        case onlyB    // c and a unchanged => substring has only 'b'
        case onlyC    // a and b unchanged => substring has only 'c'
    }

    /// Dictionary key: pattern kind + two integers describing the prefix state.
    private struct Key: Hashable {
        let kind: KeyKind
        let x: Int
        let y: Int
    }

    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n)
    ///     - For each character, we compute 7 keys (constant work).
    ///     - Dictionary ops are O(1) average.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Stores earliest index for seen prefix states.
    ///
    /// Balanced definition (as implied by original code):
    ///   Longest substring that satisfies at least one:
    ///     - a=b=c
    ///     - a=b and c=0
    ///     - b=c and a=0
    ///     - c=a and b=0
    ///     - only a's
    ///     - only b's
    ///     - only c's
    /// -----------------------------------------------------------------------
    func longestBalanced(_ s: String) -> Int {
        var firstIndexForState: [Key: Int] = [:]

        var countA = 0
        var countB = 0
        var countC = 0

        var bestLength = 0

        // Insert "prefix before string starts" as index -1 for all 7 key kinds.
        for key in makeKeys(countA, countB, countC) {
            firstIndexForState[key] = -1
        }

        for (i, ch) in s.enumerated() {
            // Update prefix counts
            if ch == "a" { countA += 1 }
            else if ch == "b" { countB += 1 }
            else { countC += 1 } // treat everything else as 'c' (per original)

            // For each pattern key, either:
            // - compute candidate length if state was seen before, or
            // - store earliest index where this state occurs.
            for key in makeKeys(countA, countB, countC) {
                if let prevIndex = firstIndexForState[key] {
                    bestLength = max(bestLength, i - prevIndex)
                } else {
                    firstIndexForState[key] = i
                }
            }
        }

        return bestLength
    }

    /// Builds the same 7 keys as your original `getKeys(a,b,c)`, but without strings.
    private func makeKeys(_ a: Int, _ b: Int, _ c: Int) -> [Key] {
        return [
            // a=b=c  -> (a-b, a-c) invariant
            Key(kind: .abc,   x: a - b, y: a - c),

            // a=b and no 'c' -> (a-b) invariant and c unchanged across substring
            Key(kind: .ab,    x: a - b, y: c),

            // b=c and no 'a' -> (b-c) invariant and a unchanged across substring
            Key(kind: .bc,    x: b - c, y: a),

            // c=a and no 'b' -> (c-a) invariant and b unchanged across substring
            Key(kind: .ca,    x: c - a, y: b),

            // only a's -> b and c unchanged
            Key(kind: .onlyA, x: b,     y: c),

            // only b's -> c and a unchanged
            Key(kind: .onlyB, x: c,     y: a),

            // only c's -> a and b unchanged
            Key(kind: .onlyC, x: a,     y: b),
        ]
    }
}