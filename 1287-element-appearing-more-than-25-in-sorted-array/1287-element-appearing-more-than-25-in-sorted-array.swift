class Solution {
    func findSpecialInteger(_ arr: [Int]) -> Int {
        let threshold = arr.count / 4
		var index = 0
		
        while index < arr.count {
			if arr[index] == arr[index+threshold] {
				return arr[index]
			} else {
				index += 1
			}
		}
        
		return 0
    }
}