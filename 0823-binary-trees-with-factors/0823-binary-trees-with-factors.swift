class Solution {
    func numFactoredBinaryTrees(_ arr: [Int]) -> Int {
        let array = arr.sorted()
        let arrayCount = array.count
        let modulo = 1_000_000_007
        
        var hashMap: [Int: Int] = [:]
        
        for index in 0..<arrayCount {
            let currentIndexElement = array[index]
            hashMap[currentIndexElement] = 1
            
            for childIndex in 0..<index {
                let currentChildIndexElement = array[childIndex]
                if currentIndexElement % currentChildIndexElement == 0 {
                    let childIndexValue = hashMap[currentChildIndexElement, default: 0]
                    let factorValue = hashMap[currentIndexElement/currentChildIndexElement, default: 0]
                    
                    hashMap[currentIndexElement, default: 0] += childIndexValue * factorValue
                }
            }
        }
        
        return hashMap.values.reduce(0, +) % modulo
    }
}
