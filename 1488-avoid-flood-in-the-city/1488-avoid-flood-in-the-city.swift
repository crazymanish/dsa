// Time Complexity: O(N²)
// The main loop iterates N times. Inside the loop, when a potential flood is detected,
// it may perform a linear scan over the array of dry days. In the worst case, this
// scan and the subsequent `remove(at:)` operation both take O(N) time. This results
// in a total complexity of O(N²). A more optimized solution using a sorted data
// structure for dry days could achieve O(N log N).
//
// Space Complexity: O(N)
// We use a dictionary (`fullLakes`) and an array (`dryDays`) which can both grow up to
// size N in the worst case. The answer array also requires O(N) space.
class Solution {
    func avoidFlood(_ rains: [Int]) -> [Int] {
        var ans = [Int](repeating: 0, count: rains.count)
        // `fullLakes`: A dictionary mapping a lake number to the day it last rained.
        var fullLakes = [Int: Int]()
        // `dryDays`: A sorted list of indices where `rains[i] == 0`.
        var dryDays = [Int]()

        for (day, lake) in rains.enumerated() {
            if lake == 0 {
                // If it's a dry day, store its index for future use.
                dryDays.append(day)
            } else {
                // It's a rainy day, so we can't dry anything. Mark it with -1.
                ans[day] = -1
                
                // Check if the lake that's about to get rain is already full.
                if let lastRainyDay = fullLakes[lake] {
                    // This lake is full! We must find a dry day to empty it.
                    // The dry day must have occurred *after* the lake was last filled.
                    
                    // **Greedy Strategy**: Find the index of the earliest possible dry day.
                    // A binary search (`firstIndex(where:)` on a sorted array) would be faster here.
                    let dryDayIndex = dryDays.firstIndex(where: { $0 > lastRainyDay })
                    
                    if let index = dryDayIndex {
                        // We found a suitable dry day. Use it.
                        let dayToUseForDrying = dryDays[index]
                        ans[dayToUseForDrying] = lake
                        
                        // This dry day is now used up; remove it from our list of options.
                        dryDays.remove(at: index)
                    } else {
                        // No available dry day was found after the last rain. A flood is inevitable.
                        return []
                    }
                }
                // Update the last rainy day for this lake to the current day.
                fullLakes[lake] = day
            }
        }
        
        // For any remaining, unused dry days, we can dry any lake. We'll just use lake 1 as a default.
        for day in dryDays {
            ans[day] = 1
        }
        
        return ans
    }
}