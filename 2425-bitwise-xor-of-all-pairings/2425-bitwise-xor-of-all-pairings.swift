class Solution {
    func xorAllNums(_ nums1: [Int], _ nums2: [Int]) -> Int {
        // We'll check the parity (even/odd) of the array lengths.
        // (n1 % 2, n2 % 2) can be (0,0), (1,0), (0,1), or (1,1).
        switch (nums1.count % 2, nums2.count % 2) {
        
        // 1) Both n1, n2 are even -> The XOR of all pairs is 0
        case (0, 0):
            return 0
        
        // 2) n1 is odd, n2 is even -> Result is XOR of all elements in nums2
        case (1, 0):
            return nums2.reduce(0, ^)
        
        // 3) n1 is even, n2 is odd -> Result is XOR of all elements in nums1
        case (0, 1):
            return nums1.reduce(0, ^)
        
        // 4) Both n1, n2 are odd -> XOR of all elements in nums1 and nums2
        default:
            return (nums1 + nums2).reduce(0, ^)
        }
    }
}