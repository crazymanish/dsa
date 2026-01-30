final class Solution {

    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   Let:
    ///     - N = source.count
    ///     - M = number of transformation rules
    ///     - K = number of distinct strings in original + changed
    ///
    ///   • Building trie:                 O(total length of original strings)
    ///   • Floyd–Warshall on K strings:   O(K³)
    ///   • DP over source string:         O(N * L)
    ///       where L = max length of a transformation string
    ///
    /// Space Complexity:
    ///   • O(K² + N + total trie size)
    ///     - Distance matrix
    ///     - DP array
    ///     - Trie
    ///
    /// Problem Summary:
    ///   Transform `source` into `target` with minimum cost.
    ///   Transformations can replace substrings (not just single characters).
    ///   Transformations may be chained.
    ///
    /// Strategy:
    ///   1. Assign IDs to all transformation strings.
    ///   2. Use Floyd–Warshall to compute cheapest transformation between strings.
    ///   3. Use DP over the source string.
    ///   4. A trie is used to efficiently find matching substrings ending at each index.
    /// -----------------------------------------------------------------------

    // MARK: - Trie Definition (stores reversed strings)

    final class TrieNode {
        var children: [UInt8: TrieNode] = [:]
        var terminalWord: String? = nil
    }

    /// Inserts a word into the trie in reverse order.
    private func insertReversed(_ root: TrieNode, _ word: String) {
        var node = root
        let bytes = Array(word.utf8)

        // Insert characters from end to start
        for index in stride(from: bytes.count - 1, through: 0, by: -1) {
            let byte = bytes[index]
            if node.children[byte] == nil {
                node.children[byte] = TrieNode()
            }
            node = node.children[byte]!
        }

        node.terminalWord = word
    }

    /// Finds all words in the trie that end at position `endIndex` in `sourceBytes`.
    private func findMatchingSuffixes(
        _ root: TrieNode,
        _ sourceBytes: [UInt8],
        _ endIndex: Int
    ) -> [String] {

        var matches = [String]()
        var node: TrieNode? = root
        var index = endIndex

        // Walk backwards through the source string
        while index >= 0, let nextNode = node?.children[sourceBytes[index]] {
            node = nextNode
            if let word = nextNode.terminalWord {
                matches.append(word)
            }
            index -= 1
        }

        return matches
    }

    // MARK: - Main Function

    func minimumCost(
        _ source: String,
        _ target: String,
        _ original: [String],
        _ changed: [String],
        _ cost: [Int]
    ) -> Int {

        // Step 1: Assign unique IDs to all transformation strings
        var stringToId = [String: Int]()
        var nextId = 0

        let trieRoot = TrieNode()

        for s in original {
            insertReversed(trieRoot, s)
            if stringToId[s] == nil {
                stringToId[s] = nextId
                nextId += 1
            }
        }

        for s in changed {
            if stringToId[s] == nil {
                stringToId[s] = nextId
                nextId += 1
            }
        }

        let INF = Int64.max / 4
        let stringCount = nextId

        // Step 2: Build distance matrix for transformations
        var minCostBetweenStrings = Array(
            repeating: Array(repeating: INF, count: stringCount),
            count: stringCount
        )

        for i in 0..<stringCount {
            minCostBetweenStrings[i][i] = 0
        }

        for i in 0..<original.count {
            let fromId = stringToId[original[i]]!
            let toId   = stringToId[changed[i]]!
            minCostBetweenStrings[fromId][toId] =
                min(minCostBetweenStrings[fromId][toId], Int64(cost[i]))
        }

        // Step 3: Floyd–Warshall (all-pairs shortest transformation cost)
        for mid in 0..<stringCount {
            for from in 0..<stringCount where minCostBetweenStrings[from][mid] < INF {
                for to in 0..<stringCount where minCostBetweenStrings[mid][to] < INF {
                    let newCost =
                        minCostBetweenStrings[from][mid] +
                        minCostBetweenStrings[mid][to]
                    if newCost < minCostBetweenStrings[from][to] {
                        minCostBetweenStrings[from][to] = newCost
                    }
                }
            }
        }

        // Step 4: DP over source string
        let sourceBytes = Array(source.utf8)
        let targetBytes = Array(target.utf8)
        let length = sourceBytes.count

        // dp[i] = minimum cost to transform source[0..<i] → target[0..<i]
        var dp = Array(repeating: INF, count: length + 1)
        dp[0] = 0

        for i in 1...length {

            // Case 1: characters already match
            if sourceBytes[i - 1] == targetBytes[i - 1] {
                dp[i] = dp[i - 1]
            }

            // Case 2: try substring transformations
            let matches = findMatchingSuffixes(trieRoot, sourceBytes, i - 1)

            for word in matches {
                let wordLength = word.utf8.count
                if i - wordLength < 0 { continue }

                let sourceSub =
                    String(decoding: sourceBytes[(i - wordLength)..<i], as: UTF8.self)
                let targetSub =
                    String(decoding: targetBytes[(i - wordLength)..<i], as: UTF8.self)

                guard
                    let fromId = stringToId[sourceSub],
                    let toId   = stringToId[targetSub],
                    minCostBetweenStrings[fromId][toId] < INF,
                    dp[i - wordLength] < INF
                else { continue }

                let newCost = dp[i - wordLength] +
                    minCostBetweenStrings[fromId][toId]

                dp[i] = min(dp[i], newCost)
            }
        }

        let answer = dp[length]
        return answer >= INF ? -1 : Int(answer)
    }
}
