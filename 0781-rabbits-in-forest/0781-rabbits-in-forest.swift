class Solution {
    func numRabbits(_ answers: [Int]) -> Int {
        var rabbitCounts: [Int: Int] = [:] // Dictionary to store the count of rabbits reporting the same number

        // Count the frequency of each answer
        for reportedCount in answers {
            rabbitCounts[reportedCount, default: 0] += 1
        }

        var totalRabbits = 0 // Initialize the total count of rabbits

        // Calculate the minimum number of rabbits based on the reported counts
        for (reportedCount, count) in rabbitCounts {
            let groupSize = reportedCount + 1 // Size of each group (including the rabbit itself)
            let numberOfGroups = (count + groupSize - 1) / groupSize // Calculate the minimum number of groups needed
            totalRabbits += numberOfGroups * groupSize // Add the estimated number of rabbits to the total
        }

        return totalRabbits // Return the estimated total number of rabbits
    }
}