// Time Complexity: O(M * N)
// Let M be the number of rows (floors) in the `bank`.
// Let N be the number of columns (the length of each string).
// 1. The `map` operation iterates through M rows. For each row, it
//    performs a `filter` and `count`, which takes O(N) time.
//    Total time for this step is O(M * N).
// 2. The `for` loop iterates through the `deviceCountsPerFloor` array,
//    which has M elements. The operations inside the loop are all O(1).
//    Total time for this step is O(M).
// The total time complexity is dominated by the first step, resulting in O(M * N).

// Space Complexity: O(M)
// We create the `deviceCountsPerFloor` array, which stores one integer
// for each of the M floors. This requires O(M) extra space.
// The other variables (`totalBeams`, `prevDeviceCount`) use constant O(1) space.

class Solution {
    /// Calculates the total number of laser beams in a bank.
    ///
    /// Beams only exist between two non-empty floors.
    /// The number of beams between two floors is the product of the
    /// number of security devices on each of those two floors.
    ///
    /// - Parameter bank: An array of strings representing the floors.
    ///   '1' is a device, '0' is empty space.
    /// - Returns: The total number of beams.
    func numberOfBeams(_ bank: [String]) -> Int {
        
        // 1. Convert each floor string into a count of devices on that floor.
        //    Example: ["011", "000", "101"] -> [2, 0, 2]
        let deviceCountsPerFloor = bank.map { floorString -> Int in
            return floorString.filter { $0 == "1" }.count
        }
        
        var totalBeams = 0
        
        // `prevDeviceCount` will store the device count of the *last*
        // floor we encountered that had one or more devices.
        // We initialize it to 0.
        var prevDeviceCount = 0
        
        // 2. Iterate through the floors, automatically skipping empty ones.
        //    The `where` clause efficiently handles floors with 0 devices.
        for currentDeviceCount in deviceCountsPerFloor where currentDeviceCount > 0 {
            
            // We are on a non-empty floor.
            // Add the beams connecting this floor to the previous non-empty floor.
            //
            // If this is the *first* non-empty floor we've seen,
            // `prevDeviceCount` will be 0, and (0 * currentDeviceCount)
            // will correctly add 0 beams.
            totalBeams += prevDeviceCount * currentDeviceCount
            
            // Now, this floor becomes the "previous" floor for the
            // next non-empty floor we find.
            prevDeviceCount = currentDeviceCount
        }
        
        // 3. Return the accumulated total.
        return totalBeams
    }
}