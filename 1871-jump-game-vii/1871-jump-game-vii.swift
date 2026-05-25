class Solution {
    /**
     Problem Summary:
     Determine whether we can reach the last index of a binary string starting from index 0.
     From index `i`, we may jump to any index in the range:
     `i + minJump...i + maxJump`, but only if that destination contains `"0"`.

     Strategy:
     Use a difference array to track how many reachable previous indices can jump to the
     current index.

     When an index is reachable and contains `"0"`, it becomes a valid launch point.
     Instead of marking every future index one by one, we mark the whole reachable range:
     - `+1` at `index + minJump`
     - `-1` after `index + maxJump`

     While scanning from left to right, the running sum tells us whether the current index
     is reachable from at least one earlier valid position.

     Time Complexity:
     O(n), where n is the length of `s`.

     Space Complexity:
     O(n), for the difference array.
     */
    func canReach(_ s: String, _ minJump: Int, _ maxJump: Int) -> Bool {
        let characters = Array(s)
        let length = characters.count
        let lastIndex = length - 1

        // We can only land on positions containing "0".
        guard characters[lastIndex] == "0" else {
            return false
        }

        // Difference array for range updates.
        // Extra capacity prevents out-of-bounds access when writing range endings.
        var reachabilityChanges = Array(repeating: 0, count: length + maxJump + 2)

        // Number of active reachable jump ranges covering the current index.
        var activeReachableRanges = 0

        for index in 0..<length {
            activeReachableRanges += reachabilityChanges[index]

            let isOpenPosition = characters[index] == "0"
            let isStartIndex = index == 0
            let canReachCurrentIndex = isStartIndex || activeReachableRanges > 0

            // Only reachable "0" positions can create future reachable ranges.
            guard isOpenPosition && canReachCurrentIndex else {
                continue
            }

            let reachableRangeStart = index + minJump
            let reachableRangeEnd = index + maxJump + 1

            reachabilityChanges[reachableRangeStart] += 1
            reachabilityChanges[reachableRangeEnd] -= 1

            // Once we know the last index is reachable, we can return immediately.
            if lastIndex >= reachableRangeStart && lastIndex < reachableRangeEnd {
                return true
            }
        }

        return lastIndex == 0
    }
}