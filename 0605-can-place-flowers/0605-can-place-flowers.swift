class Solution {
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        var placedFlowersCount = 0
        var flowerbed = flowerbed
        
        for (currentIndex, currentValue) in flowerbed.enumerated() {
            let leftValue = (currentIndex-1 == -1) ? 0 : flowerbed[currentIndex-1]
            let rightValue = (currentIndex+1 == flowerbed.count) ? 0 : flowerbed[currentIndex+1]
            
            let slice = [leftValue, currentValue, rightValue]
            // if we find 3 contiguous elements that are 0...
            if slice.reduce(0, +) == 0 {
                // then place the flower
                flowerbed[currentIndex] = 1
                
                placedFlowersCount += 1
                
                // exit early if the flowers get placed
                if placedFlowersCount == n { return true }
            }
        }
        
        return placedFlowersCount >= n
    }
}