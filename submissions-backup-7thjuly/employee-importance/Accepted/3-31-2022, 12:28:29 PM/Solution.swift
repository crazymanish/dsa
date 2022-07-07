// https://leetcode.com/problems/employee-importance

/**
 * Definition for Employee.
 * public class Employee {
 *     public var id: Int
 *     public var importance: Int
 *     public var subordinates: [Int]
 *     public init(_ id: Int, _ importance: Int, _ subordinates: [Int]) {
 *         self.id = id
 *         self.importance = importance
 *         self.subordinates = subordinates
 *     }
 * }
 */

class Solution {
    func getImportance(_ employees: [Employee], _ id: Int) -> Int {
        var hashMap: [Int : Employee] = [:]
        
        for employee in employees {
            hashMap[employee.id] = employee
        }
        
        var output = 0
        let employee = hashMap[id]!
        let queue = Queue<Employee>()
        queue.enQueue(employee)
        
        while queue.isEmpty == false {
            let currentEmployee = queue.deQueue()!
            output += currentEmployee.importance
            
            for id in currentEmployee.subordinates {
                queue.enQueue(hashMap[id]!)
            }
        }
        
        return output
    }
}

class Queue<T> {
    private var array: [T] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    func enQueue(_ element: T) {
        array.append(element)
    }
    
    func deQueue() -> T? {
        if isEmpty { return nil }
        
        return array.removeFirst()
    }
}