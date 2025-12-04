/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = directions.count
///     We pass over the string a constant number of times.
///
/// Space Complexity:
///   • O(1)
///     Only a few variables are used; the input string is not copied.
///
/// Explanation:
///   A moving car ("L" or "R") only causes a collision if it is NOT:
///     - an "L" moving off the far left edge
///     - an "R" moving off the far right edge
///
///   After trimming:
///       leading L's (safe, leave the highway)
///       trailing R's (safe, leave the highway)
///
///   Every remaining car that is not stationary ("S") will eventually collide.
/// ---------------------------------------------------------------------------
class Solution {
    func countCollisions(_ directions: String) -> Int {
        let chars = Array(directions)
        let n = chars.count
        
        var left = 0
        var right = n - 1
        var collisionCount = 0
        
        // Ignore leading 'L' cars: they move left off the road and never collide.
        while left < n && chars[left] == "L" {
            left += 1
        }
        
        // Ignore trailing 'R' cars: they move right off the road and never collide.
        while right >= 0 && chars[right] == "R" {
            right -= 1
        }
        
        // All cars between left...right that are not 'S' will collide.
        if left <= right {
            for i in left...right {
                if chars[i] != "S" {
                    collisionCount += 1
                }
            }
        }
        
        return collisionCount
    }
}
