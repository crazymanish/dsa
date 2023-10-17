class Solution {
    func validateBinaryTreeNodes(_ n: Int, _ leftChild: [Int], _ rightChild: [Int]) -> Bool {
        // keep parents
        var parents = [Int: Int]()
        for i in 0..<n {
            let left = leftChild[i]
            let right = rightChild[i]
            
            if left != -1 {
                if parents[left] != nil { return false }
                parents[left] = i
            }
            
            if right != -1 {
                if parents[right] != nil { return false }
                parents[right] = i
            }
        }
        
        // find root
        var root = 0, visited = Set<Int>()
        while let parent = parents[root] {
            if visited.contains(root) { return false }
            
            visited.insert(root)
            root = parent
        }
        
		// verify
        visited = []
        func dfs(_ i : Int) {
            if i == -1 { return }
            
            visited.insert(i)
            
            dfs(leftChild[i])
            dfs(rightChild[i])
        }
        
        dfs(root)
        return visited.count == n
    }
}