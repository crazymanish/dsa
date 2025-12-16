/// ---------------------------------------------------------------------------
/// Time Complexity:
///   Let:
///     n = number of employees
///     B = budget
///
///   This is a tree-DP with knapsack-style merges over children.
///   Each edge contributes a merge cost roughly O(B^2) in the worst case,
///   so worst-case time complexity is:
///
///     O(n * B^2)
///
/// Space Complexity:
///   • O(n * B) for dp
///   • O(n) for adjacency list + recursion stack
///
/// DP Meaning:
///   dp[u][b][0] = max profit from subtree of u with budget b if u is NOT discounted
///   dp[u][b][1] = max profit from subtree of u with budget b if u IS discounted
///
/// The "discounted" state means u can be bought at half price (present/2).
/// When u is bought, its children become eligible for discounted purchases
/// (that’s what the `buyFromChildren` accumulator represents).
/// ---------------------------------------------------------------------------
class Solution {
    func maxProfit(_ n: Int, _ present: [Int], _ future: [Int], _ hierarchy: [[Int]], _ budget: Int) -> Int {
        // Build adjacency list: manager -> direct reports
        var children = Array(repeating: [Int](), count: n + 1)
        for edge in hierarchy {
            children[edge[0]].append(edge[1])
        }

        // dp[node][budget][state], state: 0 = normal price, 1 = discounted price
        var dp = Array(
            repeating: Array(repeating: [-1, -1], count: budget + 1),
            count: n + 1
        )

        func dfs(_ node: Int) {
            // buyFromChildren[b]  = best profit from children if THIS node is bought,
            //                       which enables discounted state for children.
            // skipFromChildren[b] = best profit from children if THIS node is not bought,
            //                       children are in normal state.
            var buyFromChildren = Array(repeating: 0, count: budget + 1)
            var skipFromChildren = Array(repeating: 0, count: budget + 1)

            // Merge each child into these knapsack accumulators
            for child in children[node] {
                dfs(child)

                var nextBuy = buyFromChildren
                var nextSkip = skipFromChildren

                // Classic knapsack merge:
                // split total budget 'b' into x for previous children + y for this child
                for b in 0...budget {
                    for y in 0...b {
                        // If node is bought -> child can be in discounted state (state 1)
                        nextBuy[b] = max(nextBuy[b], buyFromChildren[b - y] + dp[child][y][1])

                        // If node is skipped -> child must be in normal state (state 0)
                        nextSkip[b] = max(nextSkip[b], skipFromChildren[b - y] + dp[child][y][0])
                    }
                }

                buyFromChildren = nextBuy
                skipFromChildren = nextSkip
            }

            let fullCost = present[node - 1]
            let discountedCost = fullCost / 2
            let gainIfBoughtFull = future[node - 1] - fullCost
            let gainIfBoughtDiscount = future[node - 1] - discountedCost

            // Fill dp[node][b][0/1]
            for b in 0...budget {
                // Option 1: skip buying this node (children in normal state)
                let skipProfit = skipFromChildren[b]

                // Option 2: buy at full price (children in discounted state)
                let buyFullProfit: Int
                if b >= fullCost {
                    buyFullProfit = max(0, gainIfBoughtFull + buyFromChildren[b - fullCost])
                } else {
                    buyFullProfit = 0
                }

                // Option 3: buy at discounted price (children in discounted state)
                let buyDiscountProfit: Int
                if b >= discountedCost {
                    buyDiscountProfit = max(0, gainIfBoughtDiscount + buyFromChildren[b - discountedCost])
                } else {
                    buyDiscountProfit = 0
                }

                // dp state definitions
                dp[node][b][0] = max(skipProfit, buyFullProfit)
                dp[node][b][1] = max(skipProfit, buyDiscountProfit)
            }
        }

        // Root is 1
        dfs(1)
        return dp[1][budget][0]
    }
}
