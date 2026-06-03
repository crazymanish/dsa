class Solution {
    /**
     Problem Summary:
     Given land and water rides with start times and durations, find the earliest possible finish time
     after completing exactly one land ride and one water ride in either order.

     Strategy:
     For each possible order:
     1. Find the earliest finish time after completing the first ride type.
     2. Use that finish time as the earliest possible start time for the second ride type.
     3. Return the better result between land-first and water-first.

     Key Insight:
     For a fixed order, choosing the ride from the first type that finishes earliest is always optimal,
     because starting the second ride earlier can never make the final finish time worse.

     Time Complexity:
     O(L + W), where L is the number of land rides and W is the number of water rides.

     Space Complexity:
     O(1), excluding input arrays.
     */
    func earliestFinishTime(
        _ landStartTime: [Int],
        _ landDuration: [Int],
        _ waterStartTime: [Int],
        _ waterDuration: [Int]
    ) -> Int {
        // Option 1: Complete a land ride first, then a water ride.
        let earliestLandFinish = earliestFinishTime(
            startTimes: landStartTime,
            durations: landDuration,
            availableAt: 0
        )

        let landThenWaterFinish = earliestFinishTime(
            startTimes: waterStartTime,
            durations: waterDuration,
            availableAt: earliestLandFinish
        )

        // Option 2: Complete a water ride first, then a land ride.
        let earliestWaterFinish = earliestFinishTime(
            startTimes: waterStartTime,
            durations: waterDuration,
            availableAt: 0
        )

        let waterThenLandFinish = earliestFinishTime(
            startTimes: landStartTime,
            durations: landDuration,
            availableAt: earliestWaterFinish
        )

        // Choose the better order.
        return min(landThenWaterFinish, waterThenLandFinish)
    }

    private func earliestFinishTime(
        startTimes: [Int],
        durations: [Int],
        availableAt: Int
    ) -> Int {
        var earliestFinish = Int.max

        for index in startTimes.indices {
            // A ride can start only after both:
            // 1. The ride is available.
            // 2. The previous ride has finished.
            let rideStartTime = max(startTimes[index], availableAt)
            let rideFinishTime = rideStartTime + durations[index]

            earliestFinish = min(earliestFinish, rideFinishTime)
        }

        return earliestFinish
    }
}