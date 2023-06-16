/*
Approach
- The number of ways to construct a BST with 0 or 1 node is 1.
- The number of ways to construct a BST with 2 nodes is 2.
- The number of ways to construct a BST with 3 nodes is 5.
- The number of ways to construct a BST with 4 nodes is 14.
- Given a sorted array of numbers, the number of ways to construct a BST is the product of the number of ways to construct a BST with each number as the root. For example, given [1, 2, 3, 4], the number of ways to construct a BST with 3 as the root is the product of the number of ways to construct a BST with [1, 2] and the number of ways to construct a BST with [4].
- For each root, the number of ways to construct a BST with n nodes is the product of the number of ways to construct a BST with j nodes and the number of ways to construct a BST with n - j - 1 nodes, where j is the number of nodes in the left subtree.
- The number of ways to construct a BST with j nodes is the jth Catalan number. The Catalan number for a given n is (2n)! / (n! * (n + 1)!). For example, the 3rd Catalan number is (2 * 3)! / (3! * 4!) = 5.
- The code above uses dynamic programming to calculate the Catalan numbers.

Complexity
- Time complexity: O(n^2)
- Space complexity: O(n^2)
*/

class Solution {
    func numOfWays(_ nums: [Int]) -> Int {
        let MOD = 1000000007
        
        func getCombs(_ nums: [Int], _ combs: [[Int]]) -> Int {
            if nums.count <= 2 { return 1 }
        
            let root = nums[0]
            var left = [Int]()
            var right = [Int]()
            for n in nums {
                if n < root {
                    left.append(n)
                } else if n > root {
                    right.append(n)
                }
            }
        
            // mod every number to avoid overflow
            return (
                combs[left.count + right.count][left.count] * 
                (getCombs(left, combs) % MOD) % MOD) * 
                getCombs(right, combs) % MOD
        }
    
        func getTriangle(_ n: Int) -> [[Int]] {
            var triangle = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        
            for i in 0..<n {
                triangle[i][0] = 1
                triangle[i][i] = 1
            }
        
            for i in 2..<n {
                for j in 1..<i {
                    triangle[i][j] = (triangle[i - 1][j] + triangle[i - 1][j - 1]) % MOD
                }
            }
            return triangle
        }
        
        let triangle = getTriangle(nums.count + 1)
        return Int(getCombs(nums, triangle)) - 1
    }
}