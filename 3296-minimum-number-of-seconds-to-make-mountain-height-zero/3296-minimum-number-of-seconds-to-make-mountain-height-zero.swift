class Solution {
    /**
     Problem Summary:
     You are given a mountain with `mountainHeight` total units to remove. Multiple workers
     remove the mountain, and each worker has a base time `t`. The time required for that
     worker to remove `k` units follows a triangular pattern:
     
         t * (1 + 2 + 3 + ... + k) = t * k * (k + 1) / 2
     
     Workers operate in parallel. The goal is to determine the **minimum number of seconds**
     required for all workers combined to remove at least `mountainHeight` units.

     Strategy:
     Use **Binary Search on Time**.
     
     For a given candidate time `T`, determine how many units each worker can remove.
     Using the triangular formula:
     
         t * k * (k + 1) / 2 ≤ T
     
     Solve for `k`:
     
         k ≈ (sqrt(1 + 8 * (T / t)) - 1) / 2
     
     Sum the removable units across all workers. If the total ≥ `mountainHeight`,
     then the time is feasible and we try a smaller value.

     Time Complexity:
     O(W * log(MaxTime))
     where W = number of workers.

     Space Complexity:
     O(1)
     */

    func minNumberOfSeconds(_ mountainHeight: Int, _ workerTimes: [Int]) -> Int {
        let targetHeight = Int64(mountainHeight)                  // Total units to remove
        let slowestWorkerTime = Int64(workerTimes.max()!)         // Worst-case worker time
        
        // Maximum possible time if the slowest worker removed everything
        let upperTimeBound = slowestWorkerTime * targetHeight * (targetHeight + 1) / 2
        
        let epsilon = 1e-7                                        // Helps avoid floating point rounding errors

        // MARK: - Feasibility Check
        // Determines whether the workers can remove at least `targetHeight`
        // within the given time limit.
        func canFinishWithin(_ timeLimit: Int64) -> Bool {

            let totalRemoved = workerTimes.lazy
                .map { workerTime -> Int64 in
                    
                    // Solve triangular inequality for k:
                    // workerTime * k * (k + 1) / 2 <= timeLimit
                    let possibleUnits = (sqrt(Double(1 + 8 * (timeLimit / Int64(workerTime)))) - 1) / 2
                    
                    return Int64(possibleUnits + epsilon)
                }
                .reduce(0, +)

            return totalRemoved >= targetHeight
        }

        // MARK: - Binary Search
        // Finds the minimum time where `canFinishWithin` becomes true.
        func binarySearchMinimumTime(_ left: Int64, _ right: Int64) -> Int64 {
            guard left < right else { return left }                // Minimal feasible time found

            let midTime = (left + right) / 2

            if canFinishWithin(midTime) {
                // If feasible, try to find an even smaller valid time
                return binarySearchMinimumTime(left, midTime)
            } else {
                // Otherwise we need more time
                return binarySearchMinimumTime(midTime + 1, right)
            }
        }

        let minimumTime = binarySearchMinimumTime(1, upperTimeBound)

        return Int(minimumTime)
    }
}