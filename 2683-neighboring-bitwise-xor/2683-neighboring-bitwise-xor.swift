class Solution {
    func doesValidArrayExist(_ derived: [Int]) -> Bool {
        // We try both possibilities for original[0]: 0 or 1
        for firstOriginalBit in [0, 1] {
            // Start with our guess for original[0]
            var originalBit = firstOriginalBit
            
            // XOR through the entire derived array; this simulates
            // how original[0] would shift if we applied all derived[] relationships
            for derivedBit in derived {
                originalBit ^= derivedBit
            }
            
            // If we're back to the same bit we started with, it means
            // the wrap-around condition derived[n-1] = original[n-1] ⊕ original[0]
            // can be satisfied. Hence, a valid original configuration exists.
            if originalBit == firstOriginalBit {
                return true
            }
        }
        
        // If neither starting bit (0 or 1) worked, no valid original array exists.
        return false
    }
}