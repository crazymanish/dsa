class Solution {
    func constrainedSubsetSum(_ nums: [Int], _ k: Int) -> Int {
        let N = nums.count
        var dp = Array(repeating: 0, count: N)
        dp[0] = nums[0]
        
        var deque = Deque<Int>()
        deque.push(dp[0])

        for i in 1..<N {
            dp[i] = max(nums[i], deque.max()! + nums[i])

            if deque.count == k {
                deque.pop()
            }
            
            deque.push(dp[i])
        }

        var result = Int.min
        for i in 0..<N {
            result = max(result, dp[i])
        }
        return result
    }
}

class Deque<T:Comparable> {
    var q = [T]()
    var maxq = [T]()
    var minq = [T]()
    
    var count : Int { q.count }
    
    var isEmpty : Bool { q.isEmpty }
    
    func push(_ ele: T) {
        q.append(ele)

        while !maxq.isEmpty, maxq.last! < ele {
            maxq.removeLast()
        }
        maxq.append(ele)

        while !minq.isEmpty, minq.last! > ele {
            minq.removeLast()
        }
        minq.append(ele)
    }

    func max() -> T? {
        return maxq.first
    }

    func min() -> T? {
        return minq.first
    }

    func pop() -> T? {
        var deleteVal = q.removeFirst()
        
        if deleteVal == maxq.first {
            maxq.removeFirst()
        }

        if deleteVal == minq.first {
            minq.removeFirst()
        }

        return deleteVal
    }
}