class Solution {
    func findThePrefixCommonArray(_ A: [Int], _ B: [Int]) -> [Int] {
        let n = A.count
        var setA = Set<Int>()
        var setB = Set<Int>()
        var result = [Int](repeating: 0, count: n)
        
        for i in 0..<n {
            // Add the current elements of A and B to their respective sets
            setA.insert(A[i])
            setB.insert(B[i])
            
            // Find the intersection of setA and setB to count common elements
            let commonElements = setA.intersection(setB)
            
            // Store the count of common elements in the result array
            result[i] = commonElements.count
        }
        
        return result
    }
}