/*
Time Complexity: O(nlogn+mlogm)
n is the number of players, m is the number of trainers.
The complexity is dominated by the two sorting operations. The subsequent two-pointer scan takes O(n+m) time.

Space Complexity: O(n+m)
In Swift, the sorted() method creates new arrays, so we use space proportional to the input sizes to store the sorted copies.
*/
class Solution {
    func matchPlayersAndTrainers(_ players: [Int], _ trainers: [Int]) -> Int {
        // Sort both players and trainers by ability in ascending order.
        // This allows us to use a greedy approach.
        let sortedPlayers = players.sorted()
        let sortedTrainers = trainers.sorted()
        
        let playerCount = sortedPlayers.count
        let trainerCount = sortedTrainers.count
        
        var matchCount = 0
        var playerIndex = 0 // Pointer for the sortedPlayers array
        var trainerIndex = 0 // Pointer for the sortedTrainers array
        
        // Iterate while there are still players and trainers to consider.
        while playerIndex < playerCount && trainerIndex < trainerCount {
            // Greedy choice: Try to match the current weakest available player
            // with the current weakest available trainer.
            if sortedPlayers[playerIndex] <= sortedTrainers[trainerIndex] {
                // Successful match! The trainer's ability is sufficient.
                matchCount += 1
                // Move to the next player and the next trainer.
                playerIndex += 1
                trainerIndex += 1
            } else {
                // The current trainer is not skilled enough for the current player.
                // Since players are sorted, this trainer won't be able to match any
                // subsequent (stronger) players either. So, we move to the next trainer.
                trainerIndex += 1
            }
        }
        
        return matchCount
    }
}