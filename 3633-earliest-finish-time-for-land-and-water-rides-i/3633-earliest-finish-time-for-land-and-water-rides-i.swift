class Solution {
    /**
     Problem Summary:
     Given land rides and water rides, each with a start time and duration,
     find the earliest possible finish time after completing exactly one land ride
     and exactly one water ride in either order.

     Strategy:
     Try both valid orders:
     1. Land ride first, then water ride.
     2. Water ride first, then land ride.

     For each pair, the second ride can only start after both:
     - the first ride has finished
     - the second ride's own start time has arrived

     Time Complexity: O(L * W)
     where L is the number of land rides and W is the number of water rides.

     Space Complexity: O(1)
     Only a few variables are used.
     */
    func earliestFinishTime(_ landStartTime: [Int], _ landDuration: [Int], _ waterStartTime: [Int], _ waterDuration: [Int]) -> Int {
        var earliestFinishTime = Int.max

        // Try taking a land ride first, then a water ride.
        for landIndex in landStartTime.indices {
            let landFinishTime = landStartTime[landIndex] + landDuration[landIndex]

            for waterIndex in waterStartTime.indices {
                let waterActualStartTime = max(landFinishTime, waterStartTime[waterIndex])
                let totalFinishTime = waterActualStartTime + waterDuration[waterIndex]

                earliestFinishTime = min(earliestFinishTime, totalFinishTime)
            }
        }

        // Try taking a water ride first, then a land ride.
        for waterIndex in waterStartTime.indices {
            let waterFinishTime = waterStartTime[waterIndex] + waterDuration[waterIndex]

            for landIndex in landStartTime.indices {
                let landActualStartTime = max(waterFinishTime, landStartTime[landIndex])
                let totalFinishTime = landActualStartTime + landDuration[landIndex]

                earliestFinishTime = min(earliestFinishTime, totalFinishTime)
            }
        }

        return earliestFinishTime
    }
}