class Solution {
    // View the whole structure as a binary tree and you can solve the problem by tracing back to the root from parent to parent
    func kthGrammar(_ n: Int, _ k: Int) -> Int {
        if n == 1 && k == 1 { return 0 }
        
        let previous = kthGrammar(n-1, (k+1) / 2)
        
        return k%2 == 0 ? 1-previous : previous
    }
}