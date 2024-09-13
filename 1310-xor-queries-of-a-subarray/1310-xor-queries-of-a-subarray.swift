class Solution {
    func xorQueries(_ arr: [Int], _ queries: [[Int]]) -> [Int] {
        var xors = [Int](repeating: 0, count: arr.count + 1)

        // Calculate prefix XORs
        for i in 0..<arr.count {
            xors[i + 1] = xors[i] ^ arr[i]
        }

        // Process each query
        var answer = [Int]()
        for query in queries {
            let left = query[0]
            let right = query[1]
            
            answer.append(xors[left] ^ xors[right + 1])
        }

        return answer
    }
}