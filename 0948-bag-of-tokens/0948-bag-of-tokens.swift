class Solution {
    func bagOfTokensScore(_ tokens: [Int], _ P: Int) -> Int {
        // sort the tokens
        // when using power, we want to buy the token that needs minimum power to get a point
        // when using point to buy a token, we want to buy a token with maximum value
        // if we exhaust all options we stop, or if we run out of points/score or power we break
        
        let tokens = tokens.sorted()
        var power = P
        var leftPointer = 0 
        var rightPointer = tokens.count-1
        var score = 0 
        var largestScore = 0
        
        while leftPointer <= rightPointer {
            //use power if possible
            if power >= tokens[leftPointer] {
                score += 1
                power -= tokens[leftPointer]
                leftPointer += 1
                //since we need to keep track of the score at any time
                largestScore = max(score, largestScore)
            } else if score > 0 {
                score -= 1
                power += tokens[rightPointer]
                rightPointer -= 1
            }  else {
                break
            }
        }
        
        return largestScore
    }
}