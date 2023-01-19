class Solution {
    func subarraysDivByK(_ nums: [Int], _ k: Int) -> Int {
      var subarrayCount = 0
      var subarraySum = 0
      var hashMap = [0 : 1]
        
      for index in 0..<nums.count {
          subarraySum += nums[index]
          
          var remainder = subarraySum % k
          if remainder < 0 { remainder += k }
          
          if let value = hashMap[remainder] {
              subarrayCount += value
              hashMap[remainder] = value + 1
          } else {
              hashMap[remainder] = 1
          }
      }
        
      return subarrayCount
    }
}