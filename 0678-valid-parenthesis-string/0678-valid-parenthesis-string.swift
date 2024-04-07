class Solution {
    func checkValidString(_ s: String) -> Bool {
        //lo => smallest possible amount of opening brackets
        //hi => largest possible amount of opening brackets
        var lo = 0, hi = 0
        
        for char in s {
            //If char is definitely an open bracket, increment lo
            if char == "(" {
                lo += 1
            //If it's a star or closing bracket, decrement
            } else {
                lo -= 1
            }
            
            //If char isn't a closed bracket, increment hi b/c it can be opening
            if char != ")" {
                hi += 1
            //It might be a closing bracket, so decrement hi
            } else {
                hi -= 1
            }
            
            //If the highest amount of opening brackets we can have is negative, we can't ever have a valid string so return false
            if hi < 0 {
                return false
            }
            
            //If lo becomes negative, reset it to 0 since we can't have a negative amount of possible opening brackets (nothing stops the next character from being opening bracket)
            lo = max(lo, 0)
        }
        
        return lo == 0
    }
}