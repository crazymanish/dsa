class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • Filtering:  O(n * L) where L = average code length (for allSatisfy)
    ///   • Sorting:    O(k log k) where k = number of valid coupons
    ///   • Mapping:    O(k)
    ///
    /// Space Complexity:
    ///   • O(k) for storing valid indices
    ///
    /// Description:
    ///   A coupon is valid if:
    ///     1. isActive[i] == true
    ///     2. businessLine[i] is in the allowed categories
    ///     3. code[i] is non-empty
    ///     4. code[i] contains only characters from `codeChars`
    ///
    ///   After filtering, the valid coupons are sorted:
    ///     • First by category (lexicographically by its first letter)
    ///     • Then by coupon code lexicographically
    /// -----------------------------------------------------------------------
    func validateCoupons(_ code: [String], _ businessLine: [String], _ isActive: [Bool]) -> [String] {
        // Allowed characters for coupon codes
        let codeChars: Set<Character> =
            Set("0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        // Valid category names
        let allowedCategories = ["electronics", "grocery", "pharmacy", "restaurant"]
        
        // Step 1: Filter valid coupons
        var validIndices = code.indices.filter { index in
            let couponCode = code[index]
            let category   = businessLine[index]
            
            return isActive[index]
                && allowedCategories.contains(category)
                && !couponCode.isEmpty
                && couponCode.allSatisfy { codeChars.contains($0) }
        }

        // Step 2: Sort valid coupons:
        //   - First by category's first letter
        //   - Then by code lexicographically
        validIndices.sort { i, j in
            let catA = businessLine[i]
            let catB = businessLine[j]
            
            let firstA = catA.first!
            let firstB = catB.first!
            
            if firstA == firstB {
                return code[i] < code[j]   // tie → sort by code
            }
            return firstA < firstB         // otherwise → sort by category
        }

        // Step 3: Return sorted coupon codes
        return validIndices.map { code[$0] }
    }
}
