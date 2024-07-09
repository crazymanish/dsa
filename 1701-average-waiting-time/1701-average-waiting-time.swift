class Solution {
    func averageWaitingTime(_ customers: [[Int]]) -> Double {
        var totalWaitingTime = 0
        var currentTime = 0

        for customer in customers {
            let arrivalTime = customer[0]
            let preparationTime = customer[1]

            if currentTime < arrivalTime {
                currentTime = arrivalTime
            }
            currentTime += preparationTime
            totalWaitingTime += currentTime - arrivalTime
        }

        return Double(totalWaitingTime) / Double(customers.count)
    }
}