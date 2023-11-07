class Solution {
    func eliminateMaximum(_ dist: [Int], _ speed: [Int]) -> Int {
        var result = 0
        var arrivals = [Int]()

        for i in 0..<dist.count {
            // need to round up for this to work correctly
            let arrivalTime = Int(ceil(Double(dist[i]) / Double(speed[i])))
            arrivals.append(arrivalTime)
        }

        arrivals = arrivals.sorted()

        for i in 0..<arrivals.count {
            if arrivals[i] <= i {
                break
            }
            
            result += 1
        }
        
        return result
    }
}