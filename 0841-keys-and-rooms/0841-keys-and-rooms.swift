class Solution {
    func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
        var roomKeys: Set<Int> = []
        
        func collectAllRoomsKeys(_ keys: [Int]) {
            for key in keys {
                let isInserted = roomKeys.insert(key).inserted
                
                if isInserted { collectAllRoomsKeys(rooms[key]) }
            }
        }
        
        // Let's collect all keys first
        collectAllRoomsKeys(rooms[0])
        
        // Let's compare if we have all rooms keys or not
        for roomNumber in 1..<rooms.count {
            if roomKeys.contains(roomNumber) == false { return false }
        }
        
        return true
    }
}