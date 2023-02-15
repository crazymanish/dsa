class Solution {
    func addToArrayForm(_ num: [Int], _ k: Int) -> [Int] {
        var outputArray: [Int] = []
        var currentK = k
        var currentIndex = num.count - 1
        
        while currentIndex >= 0 || currentK > 0 {
            currentK += currentIndex >= 0 ? num[currentIndex] : 0
            outputArray.append(currentK % 10)
            
            currentK /= 10
            currentIndex -= 1
        }
        
        return outputArray.reversed()  
  }
}