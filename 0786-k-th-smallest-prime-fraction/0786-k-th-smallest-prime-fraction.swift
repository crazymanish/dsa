class Solution {
    func kthSmallestPrimeFraction(_ arr: [Int], _ k: Int) -> [Int] {
        var indexes: [Int] = []
        var results: [Double] = [] 
        var kthFraction: [Double:[Int]] = [:]
        var currentResult: Double!
        var temp: Int!

        for i in 0..<arr.count {
            for j in (i+1)..<arr.count {
                currentResult = Double(arr[i]) / Double(arr[j])
                kthFraction[currentResult] = [arr[i],arr[j]]
                results.append(currentResult)
            }
        }
    
        var sortedResult = results.sorted()
        return kthFraction[sortedResult[k-1]]!
    }
}