class Solution {
    func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        var answer = 0
        
        for index in tickets.indices {
            if index <= k {
                answer += min(tickets[index], tickets[k])
            } else {
                answer += min(tickets[index], tickets[k]-1)
            }
        }
        
        return answer
    }
}