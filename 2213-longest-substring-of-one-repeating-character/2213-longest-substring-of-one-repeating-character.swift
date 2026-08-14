/**
 Problem Summary:
 After each character replacement, return the length of the longest
 contiguous substring containing only one repeating character.

 Strategy:
 Use a segment tree. Each node stores its boundary characters, the lengths
 of its repeating prefix and suffix, and the longest repeating run inside
 its segment. After an update, merge affected nodes back to the root.

 Time Complexity:
 Build: O(n)
 Each query: O(log n)

 Space Complexity:
 O(n)
 */
class Solution {
    func longestRepeating(_ s: String, _ queryCharacters: String, _ queryIndices: [Int]) -> [Int] {
        let characters = Array(s)
        let queryChars = Array(queryCharacters)
        let length = characters.count

        var segmentTree = Array(repeating: SegmentNode.empty, count: 4 * length)

        func merge(_ leftNode: SegmentNode, _ rightNode: SegmentNode) -> SegmentNode {
            var mergedNode = SegmentNode(
                leftCharacter: leftNode.leftCharacter,
                rightCharacter: rightNode.rightCharacter,
                prefixLength: leftNode.prefixLength,
                suffixLength: rightNode.suffixLength,
                longestRepeatingLength: max(leftNode.longestRepeatingLength, rightNode.longestRepeatingLength),
                segmentLength: leftNode.segmentLength + rightNode.segmentLength
            )

            // Matching boundary characters may create one longer repeating run.
            guard leftNode.rightCharacter == rightNode.leftCharacter else {
                return mergedNode
            }

            let joinedLength = leftNode.suffixLength + rightNode.prefixLength
            mergedNode.longestRepeatingLength = max(mergedNode.longestRepeatingLength, joinedLength)

            // The whole left segment is one repeating run, so extend its prefix.
            if leftNode.prefixLength == leftNode.segmentLength {
                mergedNode.prefixLength += rightNode.prefixLength
            }

            // The whole right segment is one repeating run, so extend its suffix.
            if rightNode.suffixLength == rightNode.segmentLength {
                mergedNode.suffixLength += leftNode.suffixLength
            }

            return mergedNode
        }

        func build(_ treeIndex: Int, _ left: Int, _ right: Int) {
            if left == right {
                let character = characters[left]
                segmentTree[treeIndex] = SegmentNode(
                    leftCharacter: character,
                    rightCharacter: character,
                    prefixLength: 1,
                    suffixLength: 1,
                    longestRepeatingLength: 1,
                    segmentLength: 1
                )
                return
            }

            let middle = (left + right) / 2
            let leftChild = treeIndex * 2 + 1
            let rightChild = treeIndex * 2 + 2

            build(leftChild, left, middle)
            build(rightChild, middle + 1, right)

            segmentTree[treeIndex] = merge(segmentTree[leftChild], segmentTree[rightChild])
        }

        func update(_ position: Int, _ newCharacter: Character, _ treeIndex: Int, _ left: Int, _ right: Int) {
            if left == right {
                segmentTree[treeIndex].leftCharacter = newCharacter
                segmentTree[treeIndex].rightCharacter = newCharacter
                return
            }

            let middle = (left + right) / 2
            let leftChild = treeIndex * 2 + 1
            let rightChild = treeIndex * 2 + 2

            // Update only the child segment that contains the changed position.
            if position <= middle {
                update(position, newCharacter, leftChild, left, middle)
            } else {
                update(position, newCharacter, rightChild, middle + 1, right)
            }

            // Rebuild this node using its updated children.
            segmentTree[treeIndex] = merge(segmentTree[leftChild], segmentTree[rightChild])
        }

        build(0, 0, length - 1)

        var result = [Int]()
        result.reserveCapacity(queryIndices.count)

        for queryIndex in 0..<queryIndices.count {
            update(queryIndices[queryIndex], queryChars[queryIndex], 0, 0, length - 1)
            result.append(segmentTree[0].longestRepeatingLength)
        }

        return result
    }
}

struct SegmentNode {
    var leftCharacter: Character
    var rightCharacter: Character
    var prefixLength: Int
    var suffixLength: Int
    var longestRepeatingLength: Int
    var segmentLength: Int

    static let empty = SegmentNode(
        leftCharacter: " ",
        rightCharacter: " ",
        prefixLength: 0,
        suffixLength: 0,
        longestRepeatingLength: 0,
        segmentLength: 0
    )
}