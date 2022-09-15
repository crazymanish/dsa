class Solution {
	func findOriginalArray(_ changed: [Int]) -> [Int] {
		if changed.count % 2 != 0 { return [] }

		var result: [Int] = []
		
        let changed = changed.sorted()
		var frequencyHashMap: [Int : Int] = [:]
		for number in changed { frequencyHashMap[number, default: 0] += 1 }
        
		for number in changed {
			if let count = frequencyHashMap[number] {
				result.append(number)
                
				if count == 1 {
					frequencyHashMap.removeValue(forKey: number)
				} else {
					frequencyHashMap[number, default: 0] -= 1
				}

				let doubleNumber = number * 2
				if let count = frequencyHashMap[doubleNumber] {
					if count == 1 {
						frequencyHashMap.removeValue(forKey: doubleNumber)
					} else {
						frequencyHashMap[doubleNumber, default: 0] -= 1
					}
				} else {
					return []
				}
			}
		}

		return result
	}
}