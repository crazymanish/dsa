class Solution {
    func findRotateSteps(_ ring: String, _ key: String) -> Int {
        let ring = Array(ring)
        let n = ring.count

        var indices: [Character: [Int]] = [:]
        for (index, char) in ring.enumerated() {
            indices[char, default: []].append(index)
        }

        var prev: [Int: Int] = [0: 0]
        for char in key {
            var next: [Int: Int] = [:]
            for j in indices[char, default: []] {
                for (i, value) in prev {
                    let steps = min(n - abs(j - i), abs(j - i))
                    let cost = value + steps + 1
                    next[j] = min(next[j, default: Int.max], cost)
                }
            }
            prev = next
        }

        return prev.values.min() ?? 0
    }
}