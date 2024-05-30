class Solution {
    func countTriplets(_ arr: [Int]) -> Int {
        var tripletCount = 0
        var prefixXOR = 0
        var countMap: [Int: Int] = [:]
        var totalMap: [Int: Int] = [:]
        
        countMap[0] = 1
        totalMap[0] = 0

        for i in 0..<arr.count {
            prefixXOR ^= arr[i]
            
            if let count = countMap[prefixXOR], let total = totalMap[prefixXOR] {
                tripletCount += count * i - total
            }
            
            totalMap[prefixXOR, default: 0] += i + 1
            countMap[prefixXOR, default: 0] += 1
        }
        
        return tripletCount
    }
}