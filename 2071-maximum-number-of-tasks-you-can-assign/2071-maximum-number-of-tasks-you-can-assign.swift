class Solution {
    /**
     * Calculates the maximum number of tasks that can be assigned to workers.
     *
     * - Parameters:
     * - tasks: An array of integers representing the difficulty of each task.
     * - workers: An array of integers representing the strength of each worker.
     * - pills: An integer representing the number of magical pills available.
     * - strength: An integer representing the strength boost a pill provides.
     * - Returns: The maximum number of tasks that can be successfully assigned.
     *
     * - Time Complexity: O(T log T + W log W + K^2 log K), where T is the number of tasks,
     * W is the number of workers, and K = min(T, W).
     * - Sorting tasks: O(T log T)
     * - Sorting workers: O(W log W)
     * - Binary search on the answer (number of tasks): O(log K) iterations.
     * - Inside each iteration (feasibility check):
     * - Selecting tasks/workers: O(K)
     * - Loop iterates K times.
     * - `removeLast()`: Amortized O(1).
     * - `findFirstIndexGreaterThanOrEqualTo`: O(log K).
     * - `remove(at:)` on Swift Array: O(K) due to shifting elements. This dominates the inner loop.
     * - Total for feasibility check: O(K * (1 + log K + K)) = O(K^2).
     * - Overall: O(T log T + W log W + log K * K^2).
     * * Optimization Note: If `strongestPotentialWorkers` used a data structure like a balanced BST or SortedList
     * (not standard in Swift Foundation, would need custom implementation or library) allowing O(log K) removal,
     * the feasibility check could be O(K log K), and the overall complexity O(T log T + W log W + K log^2 K).
     *
     * - Space Complexity: O(K), where K = min(T, W).
     * - Storing sorted copies of tasks and workers: O(T + W). If in-place sort is allowed, this could be O(log T + log W) for sort stack space.
     * - Storing `strongestPotentialWorkers` array in the feasibility check: O(K).
     * - Dominant factor is typically O(K) for the temporary worker array or O(T+W) for sorted copies if not in-place.
     */
    func maxTaskAssign(_ tasks: [Int], _ workers: [Int], _ pills: Int, _ strength: Int) -> Int {
        // Sort tasks by difficulty (ascending) and workers by strength (ascending).
        // This allows us to efficiently consider the easiest tasks and strongest workers.
        let sortedTasks = tasks.sorted()
        let sortedWorkers = workers.sorted()

        // Binary search range for the number of tasks (k) we can potentially assign.
        // The maximum possible is limited by the minimum count of tasks or workers.
        var low = 0 // Minimum possible tasks to assign
        var high = min(tasks.count, workers.count) // Maximum possible tasks to assign
        var maxTasksAssigned = 0 // Stores the maximum feasible number of tasks found so far

        // Perform binary search on the number of tasks (k).
        while low <= high {
            let potentialMaxTasks = low + (high - low) / 2 // Midpoint, potential k value to check

            // If we are checking if 0 tasks can be assigned, it's always possible.
            if potentialMaxTasks == 0 {
                maxTasksAssigned = 0
                low = potentialMaxTasks + 1 // Try checking for more tasks
                continue
            }

            // --- Feasibility Check: Can we assign `potentialMaxTasks` tasks? ---
            var pillsUsed = 0
            // Consider the `potentialMaxTasks` strongest workers. We copy them to modify freely.
            // Using the strongest workers gives the best chance to complete the tasks.
            var strongestPotentialWorkers = Array(sortedWorkers.suffix(potentialMaxTasks))
            var isFeasible = true // Assume it's possible until proven otherwise

            // Iterate through the `potentialMaxTasks` *easiest* tasks, but process them
            // from hardest (within this subset) to easiest. This greedy approach tries
            // to assign the harder tasks first, potentially saving pills and weaker workers
            // for the relatively easier tasks later in this loop.
            for taskDifficulty in sortedTasks.prefix(potentialMaxTasks).reversed() {

                // Greedily try to assign the *strongest* available worker without a pill.
                // The strongest worker (`last` element) is the most capable. Using them
                // saves pills and weaker workers.
                if let strongestWorker = strongestPotentialWorkers.last, strongestWorker >= taskDifficulty {
                    strongestPotentialWorkers.removeLast() // Assign this worker, remove from pool
                }
                // If no worker is strong enough without a pill, try using a pill.
                else if pillsUsed < pills {
                    // Find the *weakest* worker who *can* complete the task *with* a pill.
                    // Target strength needed: taskDifficulty - strength boost.
                    // We use binary search (`findFirstIndexGreaterThanOrEqualTo`) to find the
                    // first (weakest) suitable worker efficiently.
                    if let workerIndex = findFirstIndexGreaterThanOrEqualTo(strongestPotentialWorkers, taskDifficulty - strength) {
                        // Found a worker who can do it with a pill.
                        pillsUsed += 1 // Consume a pill
                        strongestPotentialWorkers.remove(at: workerIndex) // Assign this worker, remove from pool
                    } else {
                        // No worker available, even with a pill. This k is not feasible.
                        isFeasible = false
                        break // Exit the task assignment loop for this k
                    }
                }
                // No worker strong enough without a pill, and no pills left to use.
                else {
                    isFeasible = false
                    break // Exit the task assignment loop for this k
                }
            }
            // --- End Feasibility Check ---

            // Update binary search bounds based on feasibility.
            if isFeasible {
                // If `potentialMaxTasks` tasks can be assigned, it's a possible answer.
                // Store it and try to assign even more tasks.
                maxTasksAssigned = potentialMaxTasks
                low = potentialMaxTasks + 1 // Increase the lower bound
            } else {
                // If `potentialMaxTasks` tasks cannot be assigned, we need to try fewer tasks.
                high = potentialMaxTasks - 1 // Decrease the upper bound
            }
        }

        // The loop terminates when low > high, and maxTasksAssigned holds the largest k found feasible.
        return maxTasksAssigned
    }

    /**
     * Finds the index of the first element in a sorted array that is greater than or equal to a target value.
     * Used here to find the weakest worker capable of doing a task *with* a pill.
     *
     * - Parameters:
     * - sortedArray: A sorted array of integers (ascending order).
     * - minValue: The target value to search for (or the first value greater than it).
     * - Returns: The index of the first element >= minValue, or nil if no such element exists.
     *
     * - Time Complexity: O(log N), where N is the number of elements in `sortedArray`.
     * - Space Complexity: O(1).
     */
    private func findFirstIndexGreaterThanOrEqualTo(_ sortedArray: [Int], _ minValue: Int) -> Int? {
        var low = 0
        var high = sortedArray.count - 1
        var resultIndex: Int? = nil // Store the potential index found

        while low <= high {
            let mid = low + (high - low) / 2 // Prevent potential integer overflow
            if sortedArray[mid] >= minValue {
                // This element is a candidate. Store it and check the left half
                // for potentially earlier (smaller index) candidates.
                resultIndex = mid
                high = mid - 1
            } else {
                // The element is too small, search in the right half.
                low = mid + 1
            }
        }

        return resultIndex // Return the index of the first element >= minValue found
    }
}
