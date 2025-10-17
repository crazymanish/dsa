struct Data {
    var segCnt: UInt16 = 0      // Number of partitions/segments so far
    var mask: UInt32 = 0        // Bitmask representing distinct characters seen (a=bit0, b=bit1, etc.)
    var cnt: UInt16 = 0         // Count of distinct characters in current segment
    
    init(segCnt: UInt16 = 0, mask: UInt32 = 0, cnt: UInt16 = 0) {
        self.segCnt = segCnt
        self.mask = mask
        self.cnt = cnt
    }
}

class Solution {
    func maxPartitionsAfterOperations(_ s: String, _ k: Int) -> Int {
        let n = s.count
        var pref = [Data](repeating: Data(), count: n)  // Prefix data: partitions up to each index
        var suff = [Data](repeating: Data(), count: n)  // Suffix data: partitions from each index to end
        
        var seg = 0      // Current segment count
        var cnt = 0      // Current distinct character count
        var mask: UInt32 = 0  // Bitmask of seen characters in current segment
        let sArray = Array(s)
        
        // Build prefix array: process string from left to right
        // pref[i] stores partition info for substring s[0...i-1]
        for i in 0..<(n-1) {
            let charIndex = Int(sArray[i].asciiValue! - Character("a").asciiValue!)
            let bit = UInt32(1 << charIndex)
            
            // If this is a new character for current segment
            if (mask & bit) == 0 {
                // If adding this character would exceed k distinct chars, start new segment
                if cnt + 1 > k {
                    seg += 1        // Increment segment count
                    cnt = 1         // Reset count (current char is first in new segment)
                    mask = bit      // Reset mask to only current char
                } else {
                    cnt += 1        // Add new character to current segment
                    mask |= bit     // Update character mask
                }
            }
            // Store partition info at position i+1 (1-indexed)
            pref[i + 1] = Data(segCnt: UInt16(seg), mask: mask, cnt: UInt16(cnt))
        }
        
        // Reset for suffix processing
        seg = 0
        cnt = 0
        mask = 0
        
        // Build suffix array: process string from right to left  
        // suff[i] stores partition info for substring s[i+1...n-1]
        for i in stride(from: n - 1, through: 1, by: -1) {
            let charIndex = Int(sArray[i].asciiValue! - Character("a").asciiValue!)
            let bit = UInt32(1 << charIndex)
            
            // If this is a new character for current segment
            if (mask & bit) == 0 {
                // If adding this character would exceed k distinct chars, start new segment
                if cnt + 1 > k {
                    seg += 1        // Increment segment count
                    cnt = 1         // Reset count
                    mask = bit      // Reset mask
                } else {
                    cnt += 1        // Add new character
                    mask |= bit     // Update character mask
                }
            }
            // Store partition info at position i-1
            suff[i - 1] = Data(segCnt: UInt16(seg), mask: mask, cnt: UInt16(cnt))
        }
        
        var maxPartitions = 0
        
        // Try changing character at each position and calculate maximum partitions
        for i in 0..<n {
            let leftData = pref[i]    // Partition data for left part (before position i)
            let rightData = suff[i]   // Partition data for right part (after position i)
            
            // Total segments if we split at position i (left + right + current position)
            var totalSegments = Int(leftData.segCnt) + Int(rightData.segCnt) + 1
            
            // Combine character masks from left and right parts
            let combinedMask = leftData.mask | rightData.mask
            let distinctChars = combinedMask.nonzeroBitCount  // Count distinct characters
            
            // Calculate additional segments we can get by changing character at position i
            let additionalSegments: Int
            if min(distinctChars + 1, 26) <= k {
                // If changing char doesn't help (still within k distinct chars limit)
                additionalSegments = 0
            } else if leftData.cnt == k && rightData.cnt == k && distinctChars < 26 {
                // Optimal case: changing char creates two new segments
                additionalSegments = 2
            } else {
                // Standard case: changing char creates one new segment
                additionalSegments = 1
            }
            
            maxPartitions = max(maxPartitions, totalSegments + additionalSegments)
        }
        
        return maxPartitions
    }
}