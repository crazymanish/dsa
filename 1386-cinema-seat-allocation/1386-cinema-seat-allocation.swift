class Solution {
    /**
     Problem Summary:
     Given `n` cinema rows with 10 seats each, determine the maximum number
     of 4-person families that can be seated without using reserved seats.

     A family can occupy one of these seat groups:
     - Seats 2...5
     - Seats 4...7
     - Seats 6...9

     Strategy:
     - Group reserved seats by row.
     - Rows with no relevant reserved seats can always fit 2 families.
     - For rows containing reservations, check whether the left and right
       4-seat groups are available.
     - If neither outer group is available, check the middle group.

     Time Complexity:
     O(r), where `r` is the number of reserved seats.

     Space Complexity:
     O(r) for storing reserved seats grouped by row.
     */
    func maxNumberOfFamilies(_ n: Int, _ reservedSeats: [[Int]]) -> Int {
        var reservedSeatsByRow = [Int: Set<Int>]()

        // Seats 1 and 10 never affect any valid 4-person family placement,
        // so they can safely be ignored.
        for reservedSeat in reservedSeats {
            let row = reservedSeat[0]
            let seat = reservedSeat[1]

            if seat >= 2 && seat <= 9 {
                reservedSeatsByRow[row, default: []].insert(seat)
            }
        }

        // Every row without relevant reservations can fit two families:
        // one in seats 2...5 and another in seats 6...9.
        var familyCount = (n - reservedSeatsByRow.count) * 2

        for reservedSeats in reservedSeatsByRow.values {
            let leftBlockAvailable = (2...5).allSatisfy {
                !reservedSeats.contains($0)
            }

            let rightBlockAvailable = (6...9).allSatisfy {
                !reservedSeats.contains($0)
            }

            if leftBlockAvailable {
                familyCount += 1
            }

            if rightBlockAvailable {
                familyCount += 1
            }

            // The middle block overlaps both outer blocks, so it is useful
            // only when neither outer block can accommodate a family.
            if !leftBlockAvailable && !rightBlockAvailable {
                let middleBlockAvailable = (4...7).allSatisfy {
                    !reservedSeats.contains($0)
                }

                if middleBlockAvailable {
                    familyCount += 1
                }
            }
        }

        return familyCount
    }
}