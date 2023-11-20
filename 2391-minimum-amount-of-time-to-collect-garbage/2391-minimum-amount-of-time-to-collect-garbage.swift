class Solution {
    func garbageCollection(_ garbage: [String], _ travel: [Int]) -> Int {
        let travel = [0] + travel
        let trucks: [Character] = ["G","P","M"]
        var total = 0
        
        for truck in trucks {
            if let lastIndex = garbage.lastIndex(where: { $0.contains(where: { $0 == truck }) }) {
                for index in 0...lastIndex {
                    total += travel[index]
                    total += garbage[index].filter { $0 == truck }.count
                }
            }
        }
        
        return total
    }
}