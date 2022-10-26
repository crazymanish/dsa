class Solution {
	func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
		guard nums.count > 1 else { return false }
		
        var hashMap = [0: -1]
		var reminder = 0
		
        for (currentIndex, number) in nums.enumerated() {
			reminder = (reminder + number) % k
			
            if let previousIndex = hashMap[reminder] {
				if currentIndex - previousIndex > 1 {
					return true
				}
			} else {
				hashMap[reminder] = currentIndex
			}
		}
        
		return false
	}
}

/*
class Solution {
    func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
	    guard !nums.isEmpty else { return false }
	
        var size = 2
        var pointer1 = 0
	    var pointer2 = size - 1
	    
        var sum: [Int: Int] = [:]
	    sum[0] = nums[0]
	    for index in 1..<nums.count {
		    sum[index] = sum[index - 1]! + nums[index]
	    }

	    while size <= nums.count {
		    let cachedSum = sum[pointer2]! - sum[pointer1]! + nums[pointer1]
		    
            if k == 0 {
			    if cachedSum == 0 { return true }
		    } else {
			    if cachedSum % k == 0 { return true }
		    }

		    if pointer2 == nums.count - 1 {
			    size += 1
			    pointer1 = 0
			    pointer2 = size - 1
		    } else {
			    pointer1 += 1
			    pointer2 += 1
		    }
	    }

	    return false
    }
}
*/