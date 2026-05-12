class Solution {
    /**
     Problem Summary:
     Given a list of tasks where each task is represented as [actual, minimum],
     determine the minimum initial energy required to complete all tasks.

     Strategy:
     Sort tasks by the difference between minimum required energy and actual energy cost
     in descending order. Tasks with a larger "energy buffer" requirement should be done
     earlier to minimize the total initial energy needed.

     Time Complexity:
     O(n log n), where n is the number of tasks, due to sorting.

     Space Complexity:
     O(n), because sorting creates a new sorted array.
     */
    func minimumEffort(_ tasks: [[Int]]) -> Int {
        let tasksSortedByRequiredBuffer = tasks.sorted { firstTask, secondTask in
            let firstEnergyBuffer = firstTask[1] - firstTask[0]
            let secondEnergyBuffer = secondTask[1] - secondTask[0]

            return firstEnergyBuffer > secondEnergyBuffer
        }

        var availableEnergy = 0
        var requiredInitialEnergy = 0

        for task in tasksSortedByRequiredBuffer {
            let actualEnergyCost = task[0]
            let minimumEnergyRequired = task[1]

            // Add just enough initial energy so the current task can be started.
            if availableEnergy < minimumEnergyRequired {
                let extraEnergyNeeded = minimumEnergyRequired - availableEnergy
                requiredInitialEnergy += extraEnergyNeeded
                availableEnergy += extraEnergyNeeded
            }

            // Completing the task consumes its actual energy cost.
            availableEnergy -= actualEnergyCost
        }

        return requiredInitialEnergy
    }
}