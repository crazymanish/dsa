// Time Complexity: O(N + M), where N and M are the lengths of the version strings.
// - The algorithm first parses both strings into arrays of revision numbers, which
//   takes O(N + M) time.
// - It then iterates through the revisions up to the maximum length of the two
//   arrays, which is also bounded by O(N + M).
//
// Space Complexity: O(N + M)
// - Space is required to store the two arrays of integer revisions, which is
//   proportional to the lengths of the input strings.
class Solution {
    /**
     * Compares two version strings numerically.
     *
     * The strategy is to split each version string into its revision numbers. Then, we
     * compare these numbers from left to right. If one version string has fewer
     * revisions than the other, its missing revisions are treated as 0. The first
     * position where the revision numbers differ determines the result. If all
     * corresponding revisions are equal, the versions are considered the same.
     *
     * - Parameters:
     * - version1: The first version string.
     * - version2: The second version string.
     * - Returns:
     * - `1` if `version1` > `version2`
     * - `-1` if `version1` < `version2`
     * - `0` if `version1` == `version2`
     */
    func compareVersion(_ version1: String, _ version2: String) -> Int {
        // Step 1: Split the version strings by '.' and map the components to integers.
        let revisions1 = version1.components(separatedBy: ".").map { Int($0) ?? 0 }
        let revisions2 = version2.components(separatedBy: ".").map { Int($0) ?? 0 }

        // Determine the maximum number of revisions to iterate through.
        let revisionCount = max(revisions1.count, revisions2.count)
        
        // Step 2: Compare revisions at each position.
        for i in 0..<revisionCount {
            // Get the revision number for each version at the current index.
            // Use the custom subscript to safely provide 0 for missing revisions.
            let revision1 = revisions1[i, default: 0]
            let revision2 = revisions2[i, default: 0]

            // If the revisions at this position differ, we have our answer.
            if revision1 != revision2 {
                return revision1 > revision2 ? 1 : -1
            }
        }
        
        // If the loop completes without finding any differences, the versions are equal.
        return 0
    }
}

private extension Array {
    /**
     * A helper subscript to safely access an array element by index.
     * If the index is out of bounds, it returns a provided default value.
     * This is useful for treating missing version revisions as 0.
     */
    subscript (_ index: Index, default element: Element) -> Element {
        return indices.contains(index) ? self[index] : element
    }
}