class Solution {
   func countNicePairs(_ nums: [Int]) -> Int {
       let mod = 1000000007 
       var hashMap = [Int:Int]()
       var answer = 0
        
       for num in nums{
            var reverse = reverseNum(num)
            var temp = num-reverse
            answer += hashMap[temp, default: 0]
            answer %= mod
            hashMap[temp, default: 0] += 1
        }
        
       return answer
    }

    func reverseNum(_ num: Int) -> Int{
        var num = num
        var revNum = 0
        
        while num > 0 {
            revNum = revNum*10 + num%10
            num = num/10
        }
        
        return revNum
    }
}