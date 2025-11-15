/**
 Time Complexity: O(n · sqrt(n))
   - Computing `lastZeroBreak`: O(n)
   - For each end index, examining ≤ sqrt(n) dominant-ones cases: O(n · sqrt(n))

 Space Complexity: O(n)
   - Arrays `chars` and `lastZeroBreak` require O(n)

 This solution counts substrings with "dominant ones" using the mathematical
 property that only up to sqrt(n) different one-count thresholds need to be checked.
 */
class Solution {
    func numberOfSubstrings(_ s: String) -> Int {
        let chars = Array(s)
        let n = chars.count
        
        // -------------------------------------------------------------
        // Build lastZeroBreak[i]:
        //   the earliest index marking the start of the current 1-run.
        //
        // Examples:
        //   s = "110011"
        //   lastZeroBreak = [-1, -1, 1, 2, -1, -1]
        //
        //   This means:
        //   - At index 2, the previous zero is at index 1 → i - lastZeroBreak[i]
        //   - At a '0', the streak resets.
        //
        // -------------------------------------------------------------
        let lastZeroBreak: [Int] = (0..<n).reduce(into: [-1]) { arr, i in
            if i == 0 || chars[i - 1] == "0" {
                arr.append(i)                 // new run of 1's starts here
            } else {
                arr.append(arr.last!)         // continuation of the same 1-run
            }
        }
        
        // Only sqrt(n) possible interesting one-count thresholds
        let limit = Int(Double(n).squareRoot())
        
        var total = 0
        
        // -------------------------------------------------------------
        // Iterate over each ending index (1-indexed for math clarity).
        // For each end, compute the # of dominant-one substrings ending there.
        // -------------------------------------------------------------
        for (endIndex, isZeroFlag) in zip(1..., chars.map { $0 == "0" ? 1 : 0 }) {
            
            // boundary marks earliest possible starts of 1-run segments
            var boundary = endIndex
            
            // Try all possible one-count thresholds up to sqrt(n)
            for onesCount in isZeroFlag...limit {
                if boundary <= 0 { break }
                
                let prev = lastZeroBreak[boundary]
                
                // Total length of window if we start just after 'prev'
                let length = endIndex - prev
                
                // Dominance requirement: onesCount > zeros ⇒ onesCount > length - onesCount
                // The formula below counts valid starting positions.
                
                let maxPossibleStarts = length - onesCount - onesCount * onesCount + 1
                let validStarts = min(boundary - prev, max(0, maxPossibleStarts))
                
                total += validStarts
                
                // Jump boundary to previous break in the 1-run chain
                boundary = prev
            }
        }
        
        return total
    }
}
