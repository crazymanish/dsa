class Solution {
    func isHappy(_ n: Int) -> Bool {
        var hashMap: [Int : Bool] = [:]
        
        var number = n
        var isHappyNumber = false
        
        while true {
            var sum = 0
            while number != 0 {
                let digit = number % 10
                sum += digit * digit
                
                number = number / 10
            }
            
            if sum == 1{
                isHappyNumber = true // YaY, we found it!
                break
            }
            
            if hashMap[sum] == nil {
                hashMap[sum] = true
            } else {
                isHappyNumber = false // Found endless loop
                break
            }
            
            number = sum
        }
        
        return isHappyNumber
    }
}