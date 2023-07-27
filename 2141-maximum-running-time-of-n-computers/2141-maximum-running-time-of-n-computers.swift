class Solution {
    func maxRunTime(_ n: Int, _ batteries: [Int]) -> Int {
        var maximumBatteryTime = batteries.reduce(0, +)
        let sortedBatteryTimes = batteries.sorted(by: >)
        var currentIndex = 0
        
        var currentRunTime: Int { maximumBatteryTime / (n - currentIndex) }

        while sortedBatteryTimes[currentIndex] > currentRunTime {
            maximumBatteryTime -= sortedBatteryTimes[currentIndex]
            currentIndex += 1
        }
        
        return currentRunTime
    }
}