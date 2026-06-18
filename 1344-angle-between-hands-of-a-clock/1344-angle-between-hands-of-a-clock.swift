class Solution {
    /**
     Problem Summary:
     Given an hour and minute value, return the smaller angle between the hour
     hand and the minute hand on an analog clock.

     Strategy:
     - Convert both hand positions into degrees from 12 o'clock.
     - The minute hand moves 6 degrees per minute.
     - The hour hand moves 30 degrees per hour plus 0.5 degrees per minute.
     - Return the smaller angle between the direct difference and its complement.

     Time Complexity: O(1)
     Space Complexity: O(1)
     */
    func angleClock(_ hour: Int, _ minutes: Int) -> Double {
        let normalizedHour = Double(hour % 12)
        let minuteValue = Double(minutes)

        // The hour hand moves 30 degrees per hour and 0.5 degrees per minute.
        let hourHandAngle = normalizedHour * 30.0 + minuteValue * 0.5

        // The minute hand moves 6 degrees per minute.
        let minuteHandAngle = minuteValue * 6.0

        // Compute the absolute angle between both hands.
        let angleDifference = abs(hourHandAngle - minuteHandAngle)

        // The smaller angle is either the direct difference or the remaining circle.
        return min(angleDifference, 360.0 - angleDifference)
    }
}