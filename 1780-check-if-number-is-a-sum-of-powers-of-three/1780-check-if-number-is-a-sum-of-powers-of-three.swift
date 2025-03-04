class Solution {
    func checkPowersOfThree(_ n: Int) -> Bool {
        var num = n

        // Check if the number contains any power of 2
        while num > 0 {
            // If the remainder is 2, it's not a sum of distinct powers of three
            if num % 3 == 2 { return false }

            num /= 3
        }

        return true
    }
}