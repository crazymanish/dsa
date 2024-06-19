class Solution {
    func minDays(_ bloomDay: [Int], _ m: Int, _ k: Int) -> Int {
        if bloomDay.count < m * k {
            return -1
        }
        
        func isEnoughDays(_ days: Int) -> Bool {
            var bouquets = 0
            var streak = 0
            for day in bloomDay {
                if day <= days {
                    streak += 1
                } else {
                    streak = 0
                }
                if streak == k {
                    streak = 0
                    bouquets += 1
                }
            }
            return bouquets >= m
        }

        var left = 1
        var right = bloomDay.max() ?? 1
        while left < right {
            let mid = (left + right) / 2
            if isEnoughDays(mid) {
                right = mid
            } else {
                left = mid + 1
            }
        }

        return left
    }
}