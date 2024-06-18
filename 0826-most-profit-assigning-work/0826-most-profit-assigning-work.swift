class Solution {
    func maxProfitAssignment(_ difficulty: [Int], _ profit: [Int], _ worker: [Int]) -> Int {
        // Create a list of job profiles combining profit and difficulty
        var jobProfiles = [[Int]]()
        jobProfiles.append([0, 0]) // Initial dummy job with 0 profit and 0 difficulty
        
        // Combine profit and difficulty into job profiles
        for i in 0..<difficulty.count {
            jobProfiles.append([profit[i], difficulty[i]])
        }
        
        // Sort job profiles by decreasing order of profit
        jobProfiles.sort { $0[0] > $1[0] }
        
        // Update the difficulty in job profiles to have the minimum difficulty seen so far
        for i in 0..<(jobProfiles.count - 1) {
            jobProfiles[i + 1][1] = min(jobProfiles[i][1], jobProfiles[i + 1][1])
        }
        
        // Initialize total profit to 0
        var totalProfit = 0
        
        // For each worker, find the maximum profit job they can do using binary search
        for ability in worker {
            var left = 0
            var right = jobProfiles.count - 1
            var maxJobProfit = 0
            
            // Binary search for the most profitable job the worker can do
            while left <= right {
                let mid = (left + right) / 2
                if jobProfiles[mid][1] <= ability {
                    maxJobProfit = max(maxJobProfit, jobProfiles[mid][0])
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            }
            
            // Add the maximum profit the worker can earn to the total profit
            totalProfit += maxJobProfit
        }
        
        return totalProfit
    }
}