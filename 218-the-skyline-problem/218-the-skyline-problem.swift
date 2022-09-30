class Solution {
    func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
        var startPointHashMap = [Int:[Int]]()
        var endPointHashMap = [Int:[Int]]()
        var timeline = Set<Int>()

        for building in buildings {
            let startPoint = building[0]
            let endPoint = building[1]
            let height = building[2]
            startPointHashMap[startPoint,default:[]].append(height)
            endPointHashMap[endPoint,default:[]].append(height)
            timeline.insert(startPoint)
            timeline.insert(endPoint)
        }

        var previous = 0
        var sortedArray = [0]
        var result = [[Int]]()

        func binarySearch(_ n: Int) -> Int {
            var left = 0, right = sortedArray.endIndex

            while left < right {
                let mid = (left+right)>>1
                if sortedArray[mid] < n {
                    left = mid + 1
                } else {
                    right = mid
                }
            }

            return left
        }

        let sortedTimeline = timeline.sorted()
        for point in sortedTimeline {
            if startPointHashMap[point] != nil {
                for n in startPointHashMap[point]! {
                    let index = binarySearch(n)
                    sortedArray.insert(n, at: index)
                }
            }
            if endPointHashMap[point] != nil {
                for n in endPointHashMap[point]! {
                    let index = binarySearch(n)
                    sortedArray.remove(at: index)
                }
                if previous > sortedArray.last! {
                    result.append([point, sortedArray.last!])
                    previous = sortedArray.last!
                }
            }

            let current = sortedArray.last!
            if current > previous {
                result.append([point, current])
                previous = current
            }
        }

        return result
    }
}
