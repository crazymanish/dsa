class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        var queueStudents = Queue(students)
        var queueSandwiches = Queue(sandwiches)

        while !queueSandwiches.isEmpty {
            let currentSandwich = queueSandwiches.dequeue()
            var count = queueStudents.count

            while !queueStudents.isEmpty {
                if count == 0 { return queueStudents.count }
                let currentStudent = queueStudents.dequeue()

                if currentStudent != currentSandwich {
                    count -= 1
                    queueStudents.enqueue(currentStudent)
                    continue
                } 
                
                break
            }
        }

        return 0
    }
}

class Queue {
    private var elements: [Int]

    var isEmpty: Bool { elements.isEmpty }
    
    var count: Int { elements.count }

    init(_ elements: [Int]) {
        self.elements = elements
    }

    func enqueue(_ element: Int) {
        elements.append(element)
    }

    func dequeue() -> Int {
        elements.removeFirst()
    }
}