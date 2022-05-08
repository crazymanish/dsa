class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        return generateParenthesis(n, 0, 0, "")
    }
    
    private func generateParenthesis(_ n: Int, _ openBracketN: Int, _ closeBracketN: Int, _ currentParenthesis: String) -> [String] {
        if openBracketN == n && closeBracketN == n { return [currentParenthesis] }
        
        var allParenthesis: [String] = []
        
        if openBracketN < n {
            let openParenthesis = generateParenthesis(n, openBracketN+1, closeBracketN, currentParenthesis + "(")
            allParenthesis += openParenthesis
        }
        
        if closeBracketN < openBracketN {
            let closeParenthesis = generateParenthesis(n, openBracketN, closeBracketN+1, currentParenthesis + ")")
            allParenthesis += closeParenthesis
        }
        
        return allParenthesis
    }
}