// Time Complexity: O(1)
// The algorithm performs a fixed number of arithmetic operations
// (division, modulo, multiplication, addition, subtraction).
// The number of operations does not change with the size of `n`.
// Therefore, the time complexity is constant.

// Space Complexity: O(1)
// The algorithm uses only a few variables (`numFullWeeks`,
// `remainingDays`, etc.) to store intermediate results.
// The amount of space used is constant and does not depend on `n`.

class Solution {
    /// Calculates the total money saved after `n` days.
    ///
    /// The savings plan is as follows:
    /// - Day 1 (Monday): $1
    /// - Day 2 (Tuesday): $2
    /// ...
    /// - Day 7 (Sunday): $7
    /// - Day 8 (Monday): $2 (starts $1 higher than the previous Monday)
    /// - Day 9 (Tuesday): $3
    /// ...and so on.
    ///
    /// - Parameter n: The total number of days.
    /// - Returns: The total amount of money saved.
    func totalMoney(_ n: Int) -> Int {
        
        // --- 1. Divide `n` into full weeks and remaining days ---
        let numFullWeeks = n / 7
        let remainingDays = n % 7
        
        // --- 2. Calculate money from all full weeks ---
        // The money saved in each week forms an arithmetic progression:
        // Week 1: 1+2+3+4+5+6+7 = 28
        // Week 2: 2+3+4+5+6+7+8 = 35 (28 + 7)
        // Week 3: 3+4+5+6+7+8+9 = 42 (28 + 14)
        // ...
        // Week `k`: 28 + 7 * (k - 1)
        //
        // We use the formula for the sum of an arithmetic progression:
        // Sum = (numTerms / 2) * (firstTerm + lastTerm)
        //
        // - numTerms = `numFullWeeks`
        // - firstTerm (a_1) = 28
        // - lastTerm (a_n) = 28 + 7 * (numFullWeeks - 1)
        //
        // Sum = (numFullWeeks / 2) * (28 + (28 + 7 * (numFullWeeks - 1)))
        // Sum = (numFullWeeks / 2) * (56 + 7 * (numFullWeeks - 1))
        // This is what the code calculates.
        let firstWeekSavings = 28
        let lastWeekSavings = 28 + 7 * (numFullWeeks - 1)
        let totalFromFullWeeks = (firstWeekSavings + lastWeekSavings) * numFullWeeks / 2
        
        // --- 3. Calculate money from the remaining days ---
        // These days are part of the *next* week (week `numFullWeeks + 1`).
        // The savings on this week's Monday would be `1 + numFullWeeks`.
        //
        // Day 1 (Monday): 1 + numFullWeeks
        // Day 2 (Tuesday): 2 + numFullWeeks
        // ...
        // Day `d`: d + numFullWeeks
        //
        // This is another arithmetic progression:
        // - numTerms = `remainingDays`
        // - firstTerm (a_1) = (1 + numFullWeeks)
        // - lastTerm (a_n) = (remainingDays + numFullWeeks)
        //
        // Sum = (numTerms / 2) * (firstTerm + lastTerm)
        // Sum = (remainingDays / 2) * ((1 + numFullWeeks) + (remainingDays + numFullWeeks))
        // Sum = (remainingDays / 2) * (1 + remainingDays + 2 * numFullWeeks)
        // This is what the code calculates.
        let firstDaySavings = 1 + numFullWeeks
        let lastDaySavings = remainingDays + numFullWeeks
        let totalFromRemainingDays = (firstDaySavings + lastDaySavings) * remainingDays / 2
        
        // --- 4. Return the total ---
        return totalFromFullWeeks + totalFromRemainingDays
    }
}