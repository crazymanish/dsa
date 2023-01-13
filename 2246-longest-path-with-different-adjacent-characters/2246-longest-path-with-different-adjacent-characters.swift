class Solution {
  func longestPath(_ parent: [Int], _ s: String) -> Int {
    let sArray = Array(s)
    let n = sArray.count
    
    var tree = Array(repeating: [Int](), count: n)
    for i in 0..<n where parent[i] != -1 {
      tree[parent[i]].append(i)
    }
    
    var longestPath = 0 
    func dfs(_ i: Int) -> Int {
      var (currentLongestPath, secondLongestPath) = (0, 0)
      
      for j in tree[i] {
        let currentPath = dfs(j)
          
        guard sArray[i] != sArray[j] else { continue }
        
        if currentPath > currentLongestPath {
          secondLongestPath = currentLongestPath
          currentLongestPath = currentPath
        } else if currentPath > secondLongestPath {
          secondLongestPath = currentPath
        }
      }
      
      longestPath = max(longestPath, 1 + currentLongestPath + secondLongestPath)
      return 1 + currentLongestPath
    }
    
    dfs(0)
    return longestPath 
  }
}