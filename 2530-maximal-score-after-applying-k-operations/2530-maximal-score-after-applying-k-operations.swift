import Collections

class Solution {
    func maxKelements(_ nums: [Int], _ k: Int) -> Int {
        var heap = Heap(nums)
        var score = 0
        
        for _ in 0 ..< k {
            score += heap.max!
            heap.insert((heap.popMax()!+2)/3)
        }
        
        return score
    }
}