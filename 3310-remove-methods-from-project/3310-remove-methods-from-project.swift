/**
 Problem Summary:
 Return all methods that can remain after removing every method reachable
 from the suspicious method `k`. If a remaining method invokes a suspicious
 method, no method can be removed.

 Strategy:
 1. Build a directed adjacency list of method invocations.
 2. Use iterative DFS to find every method reachable from `k`.
 3. Check whether any non-suspicious method invokes a suspicious method.
 4. If such an invocation exists, return all methods; otherwise, return
    only the non-suspicious methods.

 Time Complexity:
 O(n + m), where `m` is the number of invocations.

 Space Complexity:
 O(n + m) for the adjacency list, stack, and visited set.
 */
class Solution {
    func remainingMethods(_ methodCount: Int, _ suspiciousMethod: Int, _ invocations: [[Int]]) -> [Int] {
        // Build the directed graph: caller method -> invoked methods.
        var adjacencyList = Array(repeating: [Int](), count: methodCount)

        for invocation in invocations {
            let caller = invocation[0]
            let invokedMethod = invocation[1]
            adjacencyList[caller].append(invokedMethod)
        }

        // Find every method reachable from the suspicious method.
        var suspiciousMethods: Set<Int> = [suspiciousMethod]
        var stack = [suspiciousMethod]

        while let currentMethod = stack.popLast() {
            for invokedMethod in adjacencyList[currentMethod]
                where suspiciousMethods.insert(invokedMethod).inserted {
                stack.append(invokedMethod)
            }
        }

        // A safe method invoking a suspicious method prevents removal.
        for method in 0..<methodCount where !suspiciousMethods.contains(method) {
            if adjacencyList[method].contains(where: suspiciousMethods.contains) {
                return Array(0..<methodCount)
            }
        }

        // Keep every method that is not suspicious.
        return (0..<methodCount).filter { !suspiciousMethods.contains($0) }
    }
}