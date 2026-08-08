/**
 Problem Summary:
 Find indices in `word1` that form `word2` as a subsequence,
 allowing at most one character mismatch.

 Strategy:
 - Precompute the latest possible index for every suffix of `word2`.
 - Scan `word1` from left to right.
 - Always select matching characters.
 - Select the first mismatching character only when the remaining
   suffix can still be matched afterward.

 Time Complexity: O(n + m)
 Space Complexity: O(n + m)
 */
class Solution {
    func validSequence(_ word1: String, _ word2: String) -> [Int] {
        let source = Array(word1)
        let target = Array(word2)

        let sourceCount = source.count
        let targetCount = target.count

        guard targetCount <= sourceCount else {
            return []
        }

        // suffixMatch[i] stores the latest source index that can match
        // target[i] while still allowing the rest of the target to match.
        var suffixMatch = Array(repeating: -1, count: targetCount)
        var sourceIndex = sourceCount - 1

        for targetIndex in stride(from: targetCount - 1, through: 0, by: -1) {
            while sourceIndex >= 0 && source[sourceIndex] != target[targetIndex] {
                sourceIndex -= 1
            }

            guard sourceIndex >= 0 else {
                break
            }

            suffixMatch[targetIndex] = sourceIndex
            sourceIndex -= 1
        }

        var selectedIndices: [Int] = []
        var targetIndex = 0
        var mismatchUsed = false

        for sourceIndex in 0..<sourceCount where targetIndex < targetCount {
            if source[sourceIndex] == target[targetIndex] {
                // Select matching characters greedily.
                selectedIndices.append(sourceIndex)
                targetIndex += 1
            } else if !mismatchUsed {
                // The next target character must still have a valid match
                // after selecting this character as the mismatch.
                let nextTargetIndex = targetIndex + 1
                let suffixBoundary = nextTargetIndex < targetCount
                    ? suffixMatch[nextTargetIndex]
                    : sourceCount

                if sourceIndex < suffixBoundary {
                    selectedIndices.append(sourceIndex)
                    targetIndex += 1
                    mismatchUsed = true
                }
            }
        }

        // Return the sequence only if the entire target was matched.
        return targetIndex == targetCount ? selectedIndices : []
    }
}