/** 
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return 	     -1 if num is higher than the picked number
 *			      1 if num is lower than the picked number
 *               otherwise return 0 
 * func guess(_ num: Int) -> Int 
 */

class Solution : GuessGame {
    func guessNumber(_ n: Int) -> Int {
        func findGuessNumberUsingRecursiveBinarySearch(_ startNum: Int, _ endNum: Int) -> Int {
            if startNum > endNum { return -1 } // Not found, exit base-condition
            
            let midNum = startNum + (endNum-startNum) / 2
            let midNumValue = guess(midNum) // Using given guess API
            
            if midNumValue == 0 { return midNum } // Found the answer \U0001f389
            
            if midNumValue == -1 {
                return findGuessNumberUsingRecursiveBinarySearch(startNum, midNum-1) // Guess inside left side numbers
            } else {
                return findGuessNumberUsingRecursiveBinarySearch(midNum+1, endNum) // Guess inside right side numbers
            }
        }
        
        return findGuessNumberUsingRecursiveBinarySearch(1, n)
    }
}