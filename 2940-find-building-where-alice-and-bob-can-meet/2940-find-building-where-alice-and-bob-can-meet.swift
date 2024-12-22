class Solution {
    func leftmostBuildingQueries(_ heights: [Int], _ queries: [[Int]]) -> [Int] {
        let n = queries.count
        let m = heights.count
        var ans = [Int](repeating: 0, count: n)
        var table = [Int](repeating: 0, count: m)
        var stack = [Int]()
        
        // Initialize the table with -1
        for i in 0..<m {
            table[i] = -1
        }
        
        // Fill the table with the next greater element indices
        for index in stride(from: m - 1, through: 0, by: -1) {
            while !stack.isEmpty && heights[index] >= heights[stack.last!] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                table[index] = stack.last!
            }
            stack.append(index)
        }
        
        // Process each query
        for index in 0..<n {
            let query = queries[index]
            var i = query[0], j = query[1]
            if i > j {
                swap(&i, &j)
            }
            if heights[j] > heights[i] || i == j {
                ans[index] = j
                continue
            }
            
            if table[i] == -1 || table[j] == -1 {
                ans[index] = -1
                continue
            }
            
            if heights[i] > heights[j] {
                if table[i] >= table[j] {
                    ans[index] = table[i]
                } else {
                    var k = table[j]
                    let h = heights[i]
                    
                    while k < m && heights[k] <= h {
                        k += 1
                    }
                    
                    ans[index] = k < m ? k : -1
                }
            } else {
                ans[index] = table[j]
            }
        }
        
        return ans
    }
}