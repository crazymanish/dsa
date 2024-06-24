class Solution {
    func minKBitFlips(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count

        // bool variable respresening wether the current num
        // is changed due to previous flip operations
        var flipped = false

        // right edges of performed flips
        var flipEdges: [Int] = [], flipInd = 0

        for i in 0..<n {
            // check if we reached the end of earlier flip
            if flipInd < flipEdges.count, flipEdges[flipInd] == i {
                flipped.toggle()
                flipInd += 1
            }

            // check if the resulting current num is 0
            // if it is so, perform a new flip on nums starting from current
            if (flipped && nums[i] == 1) || (!flipped && nums[i] == 0) {
                 // not enough numbers on the right to flip
                if i + k > n { return -1 }

                // flip nums[i..<(i+k)]
                flipEdges.append(i+k)
                flipped.toggle()
            }
        }
        
        // number of pefrormed flips
        return flipEdges.count
    }
}