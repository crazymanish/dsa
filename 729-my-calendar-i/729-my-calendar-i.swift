
class MyCalendar {
    var bookings: [(start: Int, end: Int)] = []
    
    init() {
        bookings = []
    }
    
    func book(_ start: Int, _ end: Int) -> Bool {
        for booking in bookings {
            let maxStart = max(booking.start, start)
            let minEnd = min(booking.end, end)
            
            if maxStart < minEnd { return false } // overlapping
        }
        
        bookings.append((start: start, end: end))
        return true
    }
}

/**
 * Your MyCalendar object will be instantiated and called as such:
 * let obj = MyCalendar()
 * let ret_1: Bool = obj.book(start, end)
 */