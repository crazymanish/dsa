class Solution {
	func findTheWinner(_ n: Int, _ k: Int) -> Int {
        var players = Array(1...n)
        var previousIndex = 0 
        
        while players.count != 1 {
			let count = players.count
            var index = previousIndex+k-1
            
            if index >= count { index %= count }
            
            players.remove(at: index)
            previousIndex = index
        }
        
        return players[0]
    }
}