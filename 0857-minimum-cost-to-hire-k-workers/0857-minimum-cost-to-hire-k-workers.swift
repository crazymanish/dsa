class Solution {
    func mincostToHireWorkers(_ quality: [Int], _ wage: [Int], _ K: Int) -> Double {
        let workers = (0..<quality.count).map { i -> (Double, Int, Int) in
            return (Double(wage[i]) / Double(quality[i]), quality[i], wage[i])
        }.sorted { $0.0 < $1.0 }

        var qsum = 0, res = Double(Int.max), heap = [Int]()
        for worker in workers {
            qsum += worker.1
            heap.append(worker.1)
            heap.sort(by: >)
            
            if heap.count > K { qsum -= heap.removeFirst() }
            if heap.count == K { res = min(res, worker.0 * Double(qsum)) }
        }
        
        return res
    }
}