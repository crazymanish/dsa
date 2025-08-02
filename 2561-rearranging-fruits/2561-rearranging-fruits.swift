// Time Complexity: O(N + S log S)
// N is the total number of elements in both baskets combined.
// S is the total number of surplus items that need to be swapped.
// The complexity is dominated by building the frequency map (O(N)) and then
// sorting the list of S imbalanced items (O(S log S)).
//
// Space Complexity: O(U + S)
// U is the number of unique elements, which determines the size of the frequency map.
// S is the number of surplus items, which determines the size of the imbalance list.
class Solution {
    func minCost(_ basket1: [Int], _ basket2: [Int]) -> Int {
        // MARK: - 1. Calculate Frequencies & Global Minimum
        var freqDiff: [Int: Int] = [:]
        var globalMin = Int.max

        // Process both baskets to find the frequency difference for each number
        // and determine the single cheapest item available across both baskets.
        for num in basket1 {
            freqDiff[num, default: 0] += 1
            globalMin = min(globalMin, num)
        }
        
        for num in basket2 {
            freqDiff[num, default: 0] -= 1
            globalMin = min(globalMin, num)
        }
        
        // MARK: - 2. Check Feasibility & Build Imbalance List
        
        // This list will contain every item that is part of a surplus in either basket.
        var imbalanceList: [Int] = []
        
        for (num, countDiff) in freqDiff {
            // For the baskets to be made equal, the total count of each number must be even.
            // An odd difference means it's impossible to balance.
            if countDiff % 2 != 0 {
                return -1
            }
            
            // Add `abs(countDiff) / 2` copies of the number to our list. This represents
            // the items that need to be moved to resolve the imbalance for this number.
            let itemsToMove = abs(countDiff) / 2
            for _ in 0..<itemsToMove {
                imbalanceList.append(num)
            }
        }
        
        // MARK: - 3. Greedy Cost Calculation

        // Sort the list of all imbalanced items to easily find the cheapest ones.
        imbalanceList.sort()
        
        var minCost = 0
        let swapCount = imbalanceList.count / 2
        let twoStepSwapCost = 2 * globalMin
        
        // The core greedy strategy: we need to perform `swapCount` swaps.
        // To minimize cost, we resolve the imbalances associated with the `swapCount`
        // cheapest items. For each of these, the cost is the minimum of its own
        // value or performing a two-step swap using the globally cheapest item.
        for i in 0..<swapCount {
            let itemCost = imbalanceList[i]
            minCost += min(itemCost, twoStepSwapCost)
        }
        
        return minCost
    }
}