class Solution {
    func largestNumber(_ nums: [Int]) -> String {
        if nums.isEmpty { return "" }
        
        var strNums = [String]()

		//Convert Int to String
        for num in nums {
            strNums.append(String(num))
        }

		// Concatenate to one another and sort
        strNums.sort { (a, b) -> Bool in
            return a + b > b + a
        }
		
		// Check for leading 0's
        return strNums.first == "0" ? "0" : strNums.joined()
    }
}