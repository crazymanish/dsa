class Solution {
    func repairCars(_ ranks: [Int], _ cars: Int) -> Int {
        var left = 1 // Minimum possible time (1 minute)
        var right = ranks.min()! * cars * cars // Maximum possible time (worst-case scenario)

        // Nested function to check if all 'cars' can be repaired within the given 'time'
        func canRepair(_ time: Int) -> Bool {
            var repairedCars = 0 // Initialize the count of repaired cars
            for rank in ranks {
                // Calculate how many cars each mechanic can repair within the given 'time'
                repairedCars += Int(sqrt(Double(time) / Double(rank)))
            }
            return repairedCars >= cars // Return true if all cars can be repaired, false otherwise
        }

        // Perform binary search to find the minimum time
        while left < right {
            let mid = left + (right - left) / 2 // Calculate the middle time
            if canRepair(mid) {
                right = mid // If all cars can be repaired within 'mid' time, search for a smaller time
            } else {
                left = mid + 1 // If all cars cannot be repaired within 'mid' time, search for a larger time
            }
        }

        return left // Return the minimum time required to repair all cars
    }
}