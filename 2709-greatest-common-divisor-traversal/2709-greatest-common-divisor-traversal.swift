class Solution {
    func canTraverseAllPairs(_ nums: [Int]) -> Bool {
        let n = nums.count
        guard n > 1 else { return true } // No pairs.
        guard !nums.contains(1) else { return false } // 1 has no primes.
        
        let maxValue = nums.max() ?? 1
        let prime = prime(maxValue)
        var unionFind = UnionFind(maxValue + 1)
        for num in nums {
            var remainder = num
            while remainder > 1 {
                let prime = prime[remainder]
                unionFind.join(prime, num)
                remainder /= prime
            }
        }
 
        let root = unionFind.rootForNode(nums[0])
        return nums.allSatisfy { unionFind.rootForNode($0) == root }
    }
    
    // Sieve of Eratosthenes.
    func prime(_ n: Int) -> [Int] {
        var prime = Array(repeating: 0, count: n + 1)
        for i in 2...n where prime[i] == 0 {
            for j in stride(from: i, through: n, by: i) {
                prime[j] = i
            }
        }
        return prime
    }
}

// Standard Union Find implementation.
struct UnionFind {
    var roots: [Int]
    var ranks: [Int]

    init(_ n: Int) {
        roots = Array(0..<n)
        ranks = Array(repeating: 0, count: n)
    }

    func rootForNode(_ node: Int) -> Int {
        var node = node
        while roots[node] != node {
            node = roots[node]
        }
        return node
    }

    mutating func join(_ a: Int, _ b: Int) {
        var rootA = rootForNode(a)
        var rootB = rootForNode(b)
        if rootA != rootB {
            if ranks[rootA] == ranks[rootB] {
                roots[rootA] = rootB
                ranks[rootB] += 1
            } else if ranks[rootA] > ranks[rootB] {
                roots[rootB] = rootA
            } else {
                roots[rootA] = rootB
            }
        }
    }
}