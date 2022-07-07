// https://leetcode.com/problems/keys-and-rooms

class Solution {
    func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
        var roomKeys: Set<Int> = []
        
        // Room0 is open, let's collect all keys
        roomKeys.formUnion(rooms[0])
        
        for roomNumber in 1..<rooms.count-1 {
            if roomKeys.contains(roomNumber) == false { return false }
            
            // let's collect all keys from this room
            roomKeys.formUnion(rooms[roomNumber])
        }
        
        return true
    }
}