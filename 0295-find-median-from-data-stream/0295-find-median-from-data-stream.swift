class MedianFinder {
	var data = [Int]()

	/** initialize your data structure here. */
	init() {
	}

	func addNum(_ num: Int) {
		if data.isEmpty {
			data.append(num)
			return
		}

		let index = binarySearch(num, 0..<data.count)
		data.insert(num, at: index)
	}

	private func binarySearch(_ num: Int, _ range: Range<Int>) -> Int {
		if range.lowerBound >= range.upperBound {
			// The number is not currently in the array return the last valid position
			return range.upperBound
		} else {
			// Find the mid point
			let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2

			// Insertion position is to the left
			if data[midIndex] > num {
				return binarySearch(num, range.lowerBound ..< midIndex)

			// Insertion position is to the right
			} else if data[midIndex] < num {
				return binarySearch(num, midIndex + 1 ..< range.upperBound)

			// Found a duplicate number
			} else {
				return midIndex
			}
		}
	}

	func findMedian() -> Double {
		guard !data.isEmpty else { return 0 }

		if data.count % 2 == 0 {
			let middle = data.count / 2
			return (Double(data[middle-1]) + Double(data[middle]))/2.0
		}
		else {
			let middle = data.count / 2
			return Double(data[middle])
		}
	}
}

/**
 * Your MedianFinder object will be instantiated and called as such:
 * let obj = MedianFinder()
 * obj.addNum(num)
 * let ret_2: Double = obj.findMedian()
 */