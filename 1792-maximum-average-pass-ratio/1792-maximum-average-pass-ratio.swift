// Time Complexity: O((N + K) * log N)
//   - N: The number of classes.
//   - K: The number of extra students.
//   - Heap Construction: We push N classes onto the heap. Each push operation
//     takes O(log N) time, leading to a total of O(N * log N) for initialization.
//   - Student Assignment: We perform K operations. Each operation involves modifying
//     the top element of the heap and then sifting it down, which takes O(log N).
//     This phase takes O(K * log N) time.
//   - The total time is the sum of these two phases.
//
// Space Complexity: O(N)
//   - The Max Heap stores a `Class` object for each of the N input classes.
//   - The space required is directly proportional to the number of classes.
class Solution {
    
    // Private nested `ClassInfo` struct to hold class data and calculate profit.
    private class ClassInfo {
        var pass: Double
        var total: Double

        // The "profit" or "gain" is the increase in the pass ratio we get
        // by adding one more student (who also passes) to this class.
        // Formula: new_ratio - old_ratio = (pass + 1)/(total + 1) - pass/total
        var profit: Double {
            let currentRatio = pass / total
            let nextRatio = (pass + 1) / (total + 1)
            return nextRatio - currentRatio
        }

        var finalRatio: Double { pass / total }

        init(_ p: Int, _ t: Int) {
            self.pass = Double(p)
            self.total = Double(t)
        }
    }

    // A simple Max Heap implementation, ordered by the `profit` of `ClassInfo` objects.
    private class MaxHeap {
        var data = [ClassInfo]()
        var isEmpty: Bool { data.isEmpty }
        var count: Int { data.count }
        
        func push(_ classInfo: ClassInfo) {
            data.append(classInfo)
            shiftUp(from: data.count - 1)
        }

        func pop() -> ClassInfo? {
            guard !isEmpty else { return nil }
            data.swapAt(0, data.count - 1)
            let popped = data.removeLast()
            shiftDown(from: 0)
            return popped
        }
        
        // Sift-up operation to maintain heap property after insertion.
        private func shiftUp(from index: Int) {
            var i = index
            guard i > 0 else { return }
            let parentIndex = (i - 1) / 2
            guard data[parentIndex].profit < data[i].profit else { return }
            data.swapAt(parentIndex, i)
            shiftUp(from: parentIndex)
        }

        // Sift-down operation to maintain heap property after removal/modification of the root.
        func shiftDown(from index: Int) {
            let leftChildIndex = 2 * index + 1
            let rightChildIndex = 2 * index + 2
            var largestIndex = index
            
            if leftChildIndex < data.count, data[leftChildIndex].profit > data[largestIndex].profit {
                largestIndex = leftChildIndex
            }
            if rightChildIndex < data.count, data[rightChildIndex].profit > data[largestIndex].profit {
                largestIndex = rightChildIndex
            }
            
            guard largestIndex != index else { return }
            data.swapAt(largestIndex, index)
            shiftDown(from: largestIndex)
        }
    }
    
    /**
     * Calculates the maximum possible average pass ratio after distributing extra students.
     *
     * The problem is solved using a greedy approach. To get the maximum average, we need to maximize
     * the sum of the individual pass ratios. At each step, we should assign an extra student to the
     * class where doing so provides the largest possible *increase* in its pass ratio.
     *
     * A Max Heap is the perfect data structure for this task. We can order the classes in the heap
     * based on their potential "profit" (the gain in ratio from adding one student). This allows us
     * to efficiently retrieve the most beneficial class to update at each of the `extraStudents` steps.
     *
     * - Parameters:
     * - classes: An array of `[pass, total]` pairs.
     * - extraStudents: The number of students to distribute.
     * - Returns: The maximum possible average pass ratio.
     */
    func maxAverageRatio(_ classes: [[Int]], _ extraStudents: Int) -> Double {
        let maxHeap = MaxHeap()
        var studentsRemaining = extraStudents

        // Step 1: Initialize the Max Heap with all the classes.
        for c in classes {
            maxHeap.push(ClassInfo(c[0], c[1]))
        }

        // Step 2: Greedily assign each extra student.
        while studentsRemaining > 0 {
            // Get the class with the highest potential profit from the top of the heap.
            guard let bestClass = maxHeap.pop() else { break }
            
            // "Assign" one student to this class.
            bestClass.pass += 1
            bestClass.total += 1
            
            // Push the updated class back into the heap. Its profit will be recalculated,
            // and it will find its new correct position.
            maxHeap.push(bestClass)
            
            studentsRemaining -= 1
        }
        
        // Step 3: Calculate the final average ratio.
        // The heap's internal array `data` now holds all the updated classes.
        let totalRatioSum = maxHeap.data.reduce(0) { $0 + $1.finalRatio }
        
        return totalRatioSum / Double(classes.count)
    }
}