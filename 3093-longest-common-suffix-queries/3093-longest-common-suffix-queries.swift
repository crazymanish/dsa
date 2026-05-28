class Solution {
    /**
     Problem Summary:
     For each query word, find the index of the word in `wordsContainer` that shares the
     longest suffix with it.

     Tie-breaking:
     1. Prefer the shorter container word.
     2. If lengths are equal, prefer the smaller index.

     Strategy:
     Build a Trie using reversed container words.
     A common suffix in the original words becomes a common prefix in the reversed Trie.
     Each Trie node stores the best container word index for the suffix represented by that node.

     Time Complexity:
     O(total characters in wordsContainer + total characters in wordsQuery)

     Space Complexity:
     O(total characters in wordsContainer)
     */
    func stringIndices(_ wordsContainer: [String], _ wordsQuery: [String]) -> [Int] {
        final class TrieNode {
            var children: [Character: TrieNode] = [:]
            var bestIndex = -1
            var bestLength = Int.max

            func updateBestMatch(wordIndex: Int, wordLength: Int) {
                if wordLength < bestLength ||
                    (wordLength == bestLength && wordIndex < bestIndex) {
                    bestIndex = wordIndex
                    bestLength = wordLength
                }
            }
        }

        let root = TrieNode()

        func insert(_ word: String, at wordIndex: Int) {
            let characters = Array(word)
            let wordLength = characters.count
            var currentNode = root

            // Root stores the best fallback answer when no suffix matches.
            currentNode.updateBestMatch(
                wordIndex: wordIndex,
                wordLength: wordLength
            )

            // Insert the word in reverse so suffix matching becomes Trie prefix matching.
            for character in characters.reversed() {
                if currentNode.children[character] == nil {
                    currentNode.children[character] = TrieNode()
                }

                currentNode = currentNode.children[character]!

                // Store the best word for the current suffix.
                currentNode.updateBestMatch(
                    wordIndex: wordIndex,
                    wordLength: wordLength
                )
            }
        }

        func queryBestIndex(for query: String) -> Int {
            var currentNode = root
            var bestMatchingIndex = root.bestIndex

            // Walk as deep as possible using the reversed query.
            for character in query.reversed() {
                guard let nextNode = currentNode.children[character] else {
                    break
                }

                currentNode = nextNode
                bestMatchingIndex = currentNode.bestIndex
            }

            return bestMatchingIndex
        }

        for (wordIndex, word) in wordsContainer.enumerated() {
            insert(word, at: wordIndex)
        }

        var result: [Int] = []
        result.reserveCapacity(wordsQuery.count)

        for query in wordsQuery {
            result.append(queryBestIndex(for: query))
        }

        return result
    }
}