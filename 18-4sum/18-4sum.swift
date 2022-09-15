class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let nums = nums.sorted()
	    return kSum(nums, target, 0, 4)
    }

    func kSum(_ nums: [Int],_ target: Int, _ start: Int, _ k: Int) -> [[Int]] {
	    var res: [[Int]] = []
	
        if (start == nums.count) || (nums[start] * k > target) || (target > nums[nums.count - 1] * k) {
		    return res
	    }
	
        if k == 2 {
		    return twoSum(nums, target, start)
	    }

	    for i in start..<nums.count {
		    if i == start || nums[i-1] != nums[i] {

			    for seq in kSum(nums, target - nums[i], i+1, k-1) {
				    res.append([nums[i]])
				    res[res.count - 1].append(contentsOf: seq)
			    }
		    }
	    }
        
	    return res
    }

    func twoSum(_ nums: [Int], _ target: Int, _ start: Int) -> [[Int]] {
	    var res: [[Int]] = []
	    var lo = start
	    var hi = nums.count - 1

	    while lo < hi {
		    let sum = nums[lo] + nums[hi]
		    if sum < target || (lo > start && nums[lo] == nums[lo - 1]) {
			    lo += 1
		    } else if sum > target || (hi < (nums.count - 1) && nums[hi] == nums[hi + 1]) {
			    hi -= 1
		    } else {
			    res.append([nums[lo], nums[hi]])
			    lo += 1
			    hi -= 1
		    }
	    }

	    return res
    }
}