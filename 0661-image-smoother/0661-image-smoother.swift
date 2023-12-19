class Solution {
    func imageSmoother(_ img: [[Int]]) -> [[Int]] {
        var answer = img

        for i in 0..<img.count {
            for j in 0..<img[i].count {
                var sum = 0
                var count = 0
                for row in i-1...i+1 where row >= 0 && row < img.count {
                    for col in j-1...j+1 where col >= 0 && col < img[i].count {
                        sum += img[row][col]
                        count += 1
                    }
                }
                answer[i][j] = (sum / count)
            }
        }

        return answer
    }
}