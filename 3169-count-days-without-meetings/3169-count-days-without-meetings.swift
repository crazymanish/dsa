class Solution {
    func countDays(_ totalDays: Int, _ meetingSchedule: [[Int]]) -> Int {
        var latestMeetingEnd = 0 // Tracks the latest end day of a meeting
        var freeDays = 0 // Counts the number of free days

        // Sort meeting schedule by start day
        let sortedMeetings = meetingSchedule.map { (startDate: $0[0], endDate: $0[1]) }.sorted(by: { $0.startDate < $1.startDate })

        // Iterate through the sorted meeting schedule
        for meeting in sortedMeetings {
            let startDate = meeting.startDate
            let endDate = meeting.endDate

            // Calculate free days before the current meeting's start
            freeDays += max(startDate - latestMeetingEnd, 1) - 1

            // Update the latest meeting end day
            latestMeetingEnd = max(latestMeetingEnd, endDate)
        }

        // Add free days after the last meeting
        freeDays += totalDays - latestMeetingEnd

        return freeDays // Return the total count of free days
    }
}