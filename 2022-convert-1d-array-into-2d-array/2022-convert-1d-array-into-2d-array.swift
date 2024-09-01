class Solution {
    func construct2DArray(_ original: [Int], _ m: Int, _ n: Int) -> [[Int]] {
		guard original.count == m * n else { return [] }

        var answer: Array<Array<Int>> = []
        var arrayNumber = 0
        var numberIndex = 0

        for _ in 1...m {
			// We append new Array for each m
            answer.append([])
            for _ in 1...n {
				// We append numbers to new Array for each n
                answer[arrayNumber].append(original[numberIndex])
                numberIndex += 1
            }
            arrayNumber += 1
        }

        return answer
    }
}