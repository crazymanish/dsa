class Solution {
    func numberOfBeams(_ bank: [String]) -> Int {
        let floors = bank.map { $0.filter { $0 == "1" }.count }
        var beams = 0
        var current = -1
        
        for devices in floors where devices > 0 {
            if current != -1 {
                beams += current * devices
            }
            
            current = devices
        }
        
        return beams
    }
}