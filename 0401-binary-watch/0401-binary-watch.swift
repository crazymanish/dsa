class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   A binary watch has:
    ///     • 4 LEDs for hours   (0–11)
    ///     • 6 LEDs for minutes (0–59)
    ///
    ///   Given `turnedOn`, return all possible times where exactly
    ///   `turnedOn` LEDs are on.
    ///
    /// Strategy:
    ///   • There are 10 LEDs total (4 hour bits + 6 minute bits).
    ///   • Use backtracking to choose exactly `turnedOn` LEDs.
    ///   • First 4 bit positions contribute to hour.
    ///   • Last 6 bit positions contribute to minute.
    ///   • Validate hour < 12 and minute < 60.
    ///   • Use pruning to stop exploring impossible branches.
    ///
    /// Time Complexity:
    ///   • O(C(10, k))
    ///     We choose `turnedOn` LEDs out of 10.
    ///     Maximum occurs when k ≈ 5 (~252 combinations).
    ///
    /// Space Complexity:
    ///   • O(k)
    ///     Recursion depth equals number of LEDs selected.
    /// -----------------------------------------------------------------------
    func readBinaryWatch(_ turnedOn: Int) -> [String] {
        var validTimes = [String]()
        
        // Backtracking function:
        // ledIndex  → current LED position (0 to 9)
        // remaining → how many LEDs still need to be turned on
        // hour      → accumulated hour value
        // minute    → accumulated minute value
        func backtrack(_ ledIndex: Int, _ remaining: Int, _ hour: Int, _ minute: Int) {  
            // If we've selected exactly the required number of LEDs
            if remaining == 0 {
                // Check if this configuration forms a valid time
                if hour < 12 && minute < 60 {
                    let formattedMinute = String(format: "%02d", minute)
                    validTimes.append("\(hour):\(formattedMinute)")
                }

                return
            }
            
            // If we've checked all LEDs, stop
            if ledIndex == 10 { return }
            
            // Prune:
            // If not enough LEDs left to fulfill remaining requirement
            if remaining > 10 - ledIndex { return }
            
            // Option 1: Turn ON this LED
            if ledIndex < 4 {
                // First 4 LEDs represent hour bits
                backtrack(ledIndex + 1, remaining - 1, hour | (1 << ledIndex), minute)
            } else {
                // Last 6 LEDs represent minute bits
                backtrack(ledIndex + 1, remaining - 1, hour, minute | (1 << (ledIndex - 4)))
            }
            
            // Option 2: Skip this LED
            backtrack(ledIndex + 1, remaining, hour, minute)
        }
        
        backtrack(0, turnedOn, 0, 0)
        return validTimes
    }
}