class Solution {
    func isPerfectSquare(_ num: Int) -> Bool {
        var left = 1
        var right = num
        
        while left <= right {
            let middle = left + (right-left)/2
            let division = num/middle
            let reminder = num%middle
            
            if division == middle && reminder == 0 {
                return true
            }
            
            if  middle > division {
                right = middle - 1
            } else {
                left = middle + 1
            }
        }
        
        return false
    }
}