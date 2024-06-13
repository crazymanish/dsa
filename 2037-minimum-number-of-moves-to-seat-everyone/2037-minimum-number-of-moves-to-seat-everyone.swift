class Solution {
    func minMovesToSeat(_ seats: [Int], _ students: [Int]) -> Int {
        var sortedSeats = seats.sorted()
        var sortedStudents = students.sorted()

        var result = 0
        for index in 0..<seats.count {
            result += abs(sortedSeats[index] - sortedStudents[index])
        }
        
        return result
    }
}