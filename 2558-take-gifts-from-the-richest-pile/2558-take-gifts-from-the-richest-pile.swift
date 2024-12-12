class Solution {
    func pickGifts(_ gifts: [Int], _ k: Int) -> Int {
        var result = gifts.sorted()
        var count = k

        while count != 0 {
            var removeValue = result.removeLast()
            removeValue = Int(sqrt(Double(removeValue)))
            result.append(removeValue)
            
            result = result.sorted()
            count -= 1
        }

        return result.reduce(0, +)
    }
}