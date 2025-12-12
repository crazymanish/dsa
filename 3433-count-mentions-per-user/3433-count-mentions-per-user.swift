/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • Sorting events: O(m log m), where m = events.count
///   • Processing events:
///       - "ALL" and "HERE" can each touch all users → O(n) per such event
///     Worst-case total: O(m log m + m * n)
///
/// Space Complexity:
///   • O(n) for returnUntil and mentionCount arrays.
///
/// Semantics:
///   - "OFFLINE" user U at time t → user is offline until (t + 60).
///   - "MESSAGE" with:
///       * "ALL"  → mention all users
///       * "HERE" → mention only those whose offline window has ended
///       * "idX idY ..." → mention specific users by their numeric IDs
/// ---------------------------------------------------------------------------

class Solution {
    func countMentions(_ numberOfUsers: Int, _ events: [[String]]) -> [Int] {
        // Step 1: Sort events by timestamp ascending.
        // If timestamps tie, process OFFLINE before MESSAGE.
        let sortedEvents = events.sorted { a, b in
            let timeA = Int(a[1])!
            let timeB = Int(b[1])!
            
            if timeA == timeB {
                // OFFLINE first when same timestamp
                if a[0] == "OFFLINE", b[0] != "OFFLINE" { return true }
                if b[0] == "OFFLINE", a[0] != "OFFLINE" { return false }
                return false
            }
            return timeA < timeB
        }
        
        // returnUntil[u] = timestamp at which user u comes back online.
        // User u is considered offline while timestamp < returnUntil[u].
        var returnUntil = [Int](repeating: 0, count: numberOfUsers)
        
        // mentionCount[u] = how many times user u was mentioned.
        var mentionCount = [Int](repeating: 0, count: numberOfUsers)
        
        // Step 2: Process each event
        for event in sortedEvents {
            let type = event[0]
            let timestamp = Int(event[1])!
            let payload = event[2]
            
            if type == "OFFLINE" {
                // payload is a user ID like "0", "1", ...
                if let userId = Int(payload), userId < numberOfUsers {
                    returnUntil[userId] = timestamp + 60
                }
                continue
            }
            
            // From here on, type is "MESSAGE"
            if payload == "ALL" {
                // Mention all users
                for user in 0..<numberOfUsers {
                    mentionCount[user] += 1
                }
            } else if payload == "HERE" {
                // Mention only online users:
                // online if returnUntil[user] <= timestamp
                for user in 0..<numberOfUsers where returnUntil[user] <= timestamp {
                    mentionCount[user] += 1
                }
            } else {
                // Explicit user list: "id1 id0 id7 ..."
                // Original logic: drop the first 2 chars ("id") and parse the rest.
                let ids = payload
                    .split(separator: " ")
                    .compactMap { token -> Int? in
                        // Match original behavior: "id42" → 42
                        Int(token.dropFirst(2))
                    }
                
                for userId in ids where userId < numberOfUsers {
                    mentionCount[userId] += 1
                }
            }
        }
        
        return mentionCount
    }
}
