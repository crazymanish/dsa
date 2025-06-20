// Time Complexity: O(n)
// The code iterates through the input string 's' once. Inside the loop, all operations
// (character comparison, arithmetic operations, min/max calculations) are constant time.
// 'n' is the length of the input string.
//
// Space Complexity: O(1)
// The algorithm uses a fixed number of variables to store counts and intermediate calculations,
// regardless of the input string's length. This makes its space complexity constant.
class Solution {
    /// Calculates the maximum possible "effective" distance from the origin achieved at any point
    /// while following a sequence of movements, with a special 'k' capacity to optimize redundant moves.
    ///
    /// The effective distance is a modified Manhattan distance.
    /// 'k' allows for optimizing pairs of opposing moves (e.g., North then South) to contribute positively
    /// to the total distance, instead of cancelling out. Each unit of 'k' used adds 2 to the distance
    /// for one pair of opposite moves that would otherwise cancel.
    ///
    /// - Parameters:
    ///   - moveSequence: A string representing the sequence of movements (e.g., "N", "S", "E", "W").
    ///   - kCapacity: An integer representing the special capacity to optimize redundant movements.
    /// - Returns: The maximum effective distance achieved from the origin at any point during the movement sequence.
    func maxDistance(_ moveSequence: String, _ kCapacity: Int) -> Int {
        // Variable to store the maximum effective distance found so far.
        var maxAchievedDistance = 0
        
        // Track the count of movements in each cardinal direction.
        var northMoves = 0
        var southMoves = 0
        var westMoves = 0
        var eastMoves = 0

        // Iterate through each character (movement direction) in the input string.
        for moveDirection in moveSequence {
            // Update the respective movement count based on the current character.
            switch moveDirection {
                case "N": northMoves += 1
                case "S": southMoves += 1
                case "W": westMoves += 1
                case "E": eastMoves += 1
                default: break // Ignore any unrecognized characters.
            }

            // Calculate the overlap in horizontal movements (minX) and the total extent (maxX).
            // minX represents steps that cancel out (e.g., 2 East and 2 West means 2 cancelling pairs).
            // maxX represents the larger extent in either East or West direction.
            let minHorizontalOverlap = min(eastMoves, westMoves)
            let maxHorizontalExtent = max(eastMoves, westMoves)
            
            // Calculate the overlap in vertical movements (minY) and the total extent (maxY).
            // minY represents steps that cancel out (e.g., 3 North and 3 South means 3 cancelling pairs).
            // maxY represents the larger extent in either North or South direction.
            let minVerticalOverlap = min(northMoves, southMoves)
            let maxVerticalExtent = max(northMoves, southMoves)

            // Calculate the current effective distance.
            // (maxHorizontalExtent - minHorizontalOverlap) is the net horizontal displacement.
            // (maxVerticalExtent - minVerticalOverlap) is the net vertical displacement.
            // This sum represents the standard Manhattan distance if kCapacity were 0.
            //
            // The term '2 * min(minHorizontalOverlap + minVerticalOverlap, kCapacity)'
            // accounts for the optimization using 'kCapacity'.
            // 'minHorizontalOverlap + minVerticalOverlap' is the total number of pairs of opposite moves
            // that cancel each other out (e.g., N-S pair, E-W pair).
            // For each unit of 'kCapacity' up to this total overlap, we can effectively convert
            // one cancelling pair into two positive steps towards distance.
            var currentEffectiveDistance = (maxHorizontalExtent - minHorizontalOverlap) +
                                           (maxVerticalExtent - minVerticalOverlap) +
                                           (2 * min(minHorizontalOverlap + minVerticalOverlap, kCapacity))
            
            // Update the maximum achieved distance if the current distance is greater.
            maxAchievedDistance = max(maxAchievedDistance, currentEffectiveDistance)
        }

        // Return the overall maximum effective distance found.
        return maxAchievedDistance
    }
}