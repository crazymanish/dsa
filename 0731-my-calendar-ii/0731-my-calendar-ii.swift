class MyCalendarTwo {
    var singleBookings = [Range<Int>]()
    var doubleBookings = [Range<Int>]()
    
    func book(_ start: Int, _ end: Int) -> Bool {
        let event = start..<end
        
        // conflict with double booked event? fail
        guard doubleBookings.first{event.overlaps($0)} == nil else { return false }
        
        // conflict with single booked event? record actual overlap as double booked
        for other in singleBookings where event.overlaps(other) {
            let lower = max(event.lowerBound, other.lowerBound) // note `max()`
            let upper = min(event.upperBound, other.upperBound) // note `min()`
            doubleBookings.append(lower..<upper)
        }
        
        singleBookings.append(event)
        return true
    }
}

/**
 * Your MyCalendarTwo object will be instantiated and called as such:
 * let obj = MyCalendarTwo()
 * let ret_1: Bool = obj.book(start, end)
 */