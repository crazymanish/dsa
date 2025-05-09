class Solution {
    /**
     * Counts the number of "balanced permutations" of the digits from a given number string `num`.
     * A permutation is balanced if the sum of its digits at odd positions equals the sum of its digits at even positions.
     * The result is modulo 1,000_000_007.
     *
     * - Parameter num: The input string of digits.
     * - Returns: The number of balanced permutations modulo 1,000_000_007.
     *
     * - Time Complexity: O(L^3 * D_max), where L is the length of the input string `num` (inputLength),
     * and D_max is the maximum possible digit value (which is 9, a constant).
     * Therefore, it can be simplified to O(L^3).
     * - Frequency counting: O(L).
     * - Binomial coefficient precomputation: O(L^2) because `numOddPositions` is O(L).
     * - Dynamic Programming:
     * - Outer loop (currentDigitType 0-9): 10 iterations (constant).
     * - `targetOddSlotsFilled` loop: O(L) iterations (`numOddPositions`).
     * - `targetSumInOddSlots` loop: O(L * D_max) iterations (`targetSumForHalf`).
     * - `countOfCurrentDigitTypeInOddSlots` loop: O(L) iterations (max frequency of a digit, `frequencyOfCurrentDigitType`).
     * - Total DP: O(10 * L * (L * D_max) * L) = O(L^3 * D_max).
     * The DP part dominates the complexity.
     *
     * - Space Complexity: O(L^2 * D_max), which simplifies to O(L^2) as D_max is constant.
     * - `digitFrequencies`: O(1) (fixed size 10).
     * - `binomialCoefficients`: O(L^2) as `numOddPositions` is O(L).
     * - `dpTable`: `targetSumForHalf` * `numOddPositions` = O(L * D_max) * O(L) = O(L^2 * D_max).
     * The `dpTable` dominates the space complexity.
     */
    func countBalancedPermutations(_ num: String) -> Int {
        let moduloConstant = 1_000_000_007
        let inputLength = num.count

        // Step 1: Preprocessing - Count digit frequencies and total sum.
        var digitFrequencies = [Int](repeating: 0, count: 10) // Stores frequency of digits 0-9
        var sumOfAllDigits = 0 // Sum of all digits in the input string
        for charValue in num {
            if let digit = charValue.wholeNumberValue { // Safely convert Character to Int
                digitFrequencies[digit] += 1
                sumOfAllDigits += digit
            }
        }
    
        // If sumOfAllDigits is odd, it's impossible to partition into two equal sum halves.
        guard sumOfAllDigits.isMultiple(of: 2) else {
            return 0 // No balanced permutations possible
        }

        // The target sum for digits in odd positions (and also for even positions).
        let targetSumForHalf = sumOfAllDigits / 2
        // Calculate the number of available odd and even indexed positions in the permutation.
        // For a 0-indexed permutation of length L:
        // Odd positions: 1, 3, 5, ... (indices 0, 2, 4, ...)
        // Even positions: 2, 4, 6, ... (indices 1, 3, 5, ...)
        // The problem statement usually implies 1-indexed positions for "odd/even positions".
        // If 1-indexed: odd positions are 1, 3, ..., even positions are 2, 4, ...
        // Number of odd positions = ceil(L/2)
        // Number of even positions = floor(L/2)
        let numOddPositions = (inputLength + 1) / 2 // Count of 1st, 3rd, 5th... positions
        let numEvenPositions = inputLength - numOddPositions // Count of 2nd, 4th, 6th... positions

        // Step 2: Precompute binomial coefficients C(n, k) % moduloConstant.
        // binomialCoefficients[i][j] will store C(i, j).
        // Needed for calculating ways to choose positions for digits.
        // Max value for 'n' in C(n,k) will be numOddPositions or numEvenPositions.
        var binomialCoefficients = Array(repeating: Array(repeating: 0, count: numOddPositions + 1), count: numOddPositions + 1)
        for i in 0...numOddPositions {
            binomialCoefficients[i][0] = 1 // C(i, 0) = 1
            if i > 0 {
                for j in 1...i {
                    // C(i, j) = C(i-1, j) + C(i-1, j-1)
                    binomialCoefficients[i][j] = (binomialCoefficients[i - 1][j] + binomialCoefficients[i - 1][j - 1]) % moduloConstant
                }
            }
        }

        // Step 3: Dynamic Programming
        // dpTable[sum][oddSlotsFilled] = number of ways to arrange the 'totalDigitsConsidered' so far,
        // such that exactly 'oddSlotsFilled' of them are placed in odd-indexed positions,
        // AND the sum of these 'oddSlotsFilled' digits is 'sum'.
        var dpTable = Array(repeating: Array(repeating: 0, count: numOddPositions + 1), count: targetSumForHalf + 1)
        // Base case: There's 1 way to achieve a sum of 0 using 0 digits in odd positions (the empty arrangement before any digits are processed).
        dpTable[0][0] = 1 

        var totalDigitsConsidered = 0 // Running count of how many digits (e.g., two '1's, one '5') have been placed.
        var currentSumOfAllConsideredDigits = 0 // Running sum of all digits that have been placed.

        // Iterate through each type of digit (0 through 9).
        for currentDigitType in 0...9 {
            let frequencyOfCurrentDigitType = digitFrequencies[currentDigitType]
            // If the current digit type is not present in the input number, skip it.
            if frequencyOfCurrentDigitType == 0 {
                continue
            }
            
            // After processing this 'currentDigitType', these will be the new totals.
            let updatedTotalDigitsConsidered = totalDigitsConsidered + frequencyOfCurrentDigitType
            let updatedSumOfAllConsideredDigits = currentSumOfAllConsideredDigits + currentDigitType * frequencyOfCurrentDigitType

            // Iterate DP states backwards. This ensures that when we calculate dpTable[s][o]
            // using previous states, those previous states are from *before* considering the currentDigitType.
            // targetOddSlotsFilled: The number of odd-indexed positions filled *after* placing the currentDigitType.
            for targetOddSlotsFilled in (0...min(updatedTotalDigitsConsidered, numOddPositions)).reversed() {
                // targetEvenSlotsFilled: The number of even-indexed positions filled *after* placing the currentDigitType.
                let targetEvenSlotsFilled = updatedTotalDigitsConsidered - targetOddSlotsFilled
                // Validate if the number of even slots to be filled is possible.
                if targetEvenSlotsFilled < 0 || targetEvenSlotsFilled > numEvenPositions {
                    continue // Not enough even slots, or too many even slots required.
                }

                // targetSumInOddSlots: The sum of digits in odd-indexed positions *after* placing the currentDigitType.
                for targetSumInOddSlots in (0...min(updatedSumOfAllConsideredDigits, targetSumForHalf)).reversed() {
                    // Pruning: If the sum of digits in even positions (updatedSumOfAllConsideredDigits - targetSumInOddSlots)
                    // already exceeds targetSumForHalf, this path cannot lead to a balanced permutation.
                    if updatedSumOfAllConsideredDigits - targetSumInOddSlots > targetSumForHalf {
                        // If we were building dpTable forward, we'd set dpTable[targetSumInOddSlots][targetOddSlotsFilled] = 0 here.
                        // Since we are calculating it from scratch (waysToReachCurrentDpState = 0), we can just skip.
                        continue;
                    }
                    
                    var waysToReachCurrentDpState = 0 // Initialize ways for dpTable[targetSumInOddSlots][targetOddSlotsFilled]
                    
                    // Now, consider how many of the 'frequencyOfCurrentDigitType' instances of 'currentDigitType'
                    // are placed in odd positions, and how many in even positions.
                    // countOfCurrentDigitTypeInOddSlots: Number of 'currentDigitType' instances placed in odd slots.
                    for countOfCurrentDigitTypeInOddSlots in 0...frequencyOfCurrentDigitType {
                        // countOfCurrentDigitTypeInEvenSlots: Number of 'currentDigitType' instances placed in even slots.
                        let countOfCurrentDigitTypeInEvenSlots = frequencyOfCurrentDigitType - countOfCurrentDigitTypeInOddSlots

                        // Check if this distribution is possible given the target slot counts.
                        // We can't place more of currentDigitType in odd slots than targetOddSlotsFilled.
                        // Similarly for even slots.
                        if countOfCurrentDigitTypeInOddSlots > targetOddSlotsFilled || countOfCurrentDigitTypeInEvenSlots > targetEvenSlotsFilled {
                            continue
                        }
                        
                        // Calculate the state *before* placing the currentDigitType instances.
                        // previousOddSumTarget: Sum in odd slots *before* adding 'countOfCurrentDigitTypeInOddSlots' of 'currentDigitType'.
                        let previousOddSumTarget = targetSumInOddSlots - currentDigitType * countOfCurrentDigitTypeInOddSlots
                        // previousOddSlotsFilledTarget: Number of odd slots filled *before* adding 'countOfCurrentDigitTypeInOddSlots' of 'currentDigitType'.
                        let previousOddSlotsFilledTarget = targetOddSlotsFilled - countOfCurrentDigitTypeInOddSlots
                        
                        // Check if this previous state is valid.
                        if previousOddSumTarget >= 0 && previousOddSlotsFilledTarget >= 0 && previousOddSlotsFilledTarget <= totalDigitsConsidered {
                            // If there were ways to reach the previous state:
                            if dpTable[previousOddSumTarget][previousOddSlotsFilledTarget] > 0 {
                                // Ways to choose 'countOfCurrentDigitTypeInOddSlots' positions for the current digit type
                                // from the 'targetOddSlotsFilled' total odd positions being formed.
                                let waysToChooseOddPos = binomialCoefficients[targetOddSlotsFilled][countOfCurrentDigitTypeInOddSlots]
                                
                                // Ways to choose 'countOfCurrentDigitTypeInEvenSlots' positions for the current digit type
                                // from the 'targetEvenSlotsFilled' total even positions being formed.
                                let waysToChooseEvenPos = binomialCoefficients[targetEvenSlotsFilled][countOfCurrentDigitTypeInEvenSlots]
                                
                                // Calculate contribution from this specific distribution of currentDigitType
                                var contributionToWays = dpTable[previousOddSumTarget][previousOddSlotsFilledTarget]
                                contributionToWays = (contributionToWays * waysToChooseOddPos) % moduloConstant
                                contributionToWays = (contributionToWays * waysToChooseEvenPos) % moduloConstant
                                
                                // Add to total ways for the current DP state
                                waysToReachCurrentDpState = (waysToReachCurrentDpState + contributionToWays) % moduloConstant
                            }
                        }
                    }
                    // Update the DP table with the calculated ways for the current state.
                    dpTable[targetSumInOddSlots][targetOddSlotsFilled] = waysToReachCurrentDpState
                }
            }
            // After processing all states for the currentDigitType, update the overall counts.
            totalDigitsConsidered = updatedTotalDigitsConsidered
            currentSumOfAllConsideredDigits = updatedSumOfAllConsideredDigits
        }

        // The final answer is the number of ways to fill 'numOddPositions'
        // such that their sum is 'targetSumForHalf', using all digits from the input.
        return dpTable[targetSumForHalf][numOddPositions]
    }
}
