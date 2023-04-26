class Solution {
    func addDigits(_ num: Int) -> Int {
        var num = num
        
        while num > 9 {
            let reminder = num % 10
            num = num / 10
            num = reminder + num
        }
        
        return num
    }
}