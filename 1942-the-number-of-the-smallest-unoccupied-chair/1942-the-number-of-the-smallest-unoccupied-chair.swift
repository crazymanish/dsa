class Solution {
    func smallestChair(_ times: [[Int]], _ targetFriend: Int) -> Int {
        // Array to store the events (arrival or departure)
        var events = [(time: Int, type: String, friend: Int)]()
        
        // Populate the events array with both arrival and departure events
        for (index, time) in times.enumerated() {
            events.append((time: time[0], type: "arrive", friend: index))
            events.append((time: time[1], type: "leave", friend: index))
        }
        
        // Sort events by time, and in case of a tie, process departures first
        events.sort { a, b in
            if a.time == b.time {
                return a.type > b.type  // Departure ('leave') comes before arrival ('arrive')
            } else {
                return a.time < b.time
            }
        }
        
        // Min-heap (priority queue) to track the smallest available chair
        var availableChairs = [Int]()
        for i in 0..<times.count {
            availableChairs.append(i)
        }
        
        // Sort the available chairs to always take the smallest available chair
        availableChairs.sort()
        
        // Dictionary to store which friend is sitting on which chair
        var sitting = [Int: Int]()
        
        for event in events {
            let friend = event.friend
            
            if event.type == "arrive" {
                // Take the smallest available chair
                let chair = availableChairs.removeFirst()
                sitting[friend] = chair
                
                // If this is the target friend, return their chair
                if friend == targetFriend {
                    return chair
                }
            } else if event.type == "leave" {
                // Free the chair that the friend was sitting on
                if let chair = sitting[friend] {
                    availableChairs.append(chair)
                    availableChairs.sort()  // Re-sort after adding the chair back
                }
            }
        }
        
        return -1  // This line should never be reached
    }
}