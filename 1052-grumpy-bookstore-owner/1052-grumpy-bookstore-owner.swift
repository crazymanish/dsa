class Solution {
    func maxSatisfied(_ customers: [Int], _ grumpy: [Int], _ X: Int) -> Int {
        var totalSatisfiedCustomers = 0
        var maxAdditionalSatisfiedCustomers = 0
        var currentAdditionalSatisfiedCustomers = 0

        for i in 0..<grumpy.count {
            if grumpy[i] == 0 {
                // Add customers to total satisfied customers if the owner is not grumpy
                totalSatisfiedCustomers += customers[i]
            } else {
                // Add customers to the current window of additional satisfied customers if the owner is grumpy
                currentAdditionalSatisfiedCustomers += customers[i]
            }

            // Maintain the window size of X
            if i >= X {
                // Subtract the customers that fall out of the current window
                currentAdditionalSatisfiedCustomers -= grumpy[i - X] * customers[i - X]
            }

            // Update the maximum additional satisfied customers
            maxAdditionalSatisfiedCustomers = max(currentAdditionalSatisfiedCustomers, maxAdditionalSatisfiedCustomers)
        }

        // Return the sum of always satisfied customers and the maximum additional satisfied customers
        return totalSatisfiedCustomers + maxAdditionalSatisfiedCustomers
    }
}