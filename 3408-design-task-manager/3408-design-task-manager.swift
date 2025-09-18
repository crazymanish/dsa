
class TaskManager {

    struct Task: Hashable, Comparable {
        let userID: Int
        let taskID: Int
        let priority: Int

        static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.priority == rhs.priority ? lhs.taskID < rhs.taskID : lhs.priority < rhs.priority
        }
    }

    var taskMap = [Int: Task]()
    var heap = Heap<Task>()

    init(_ tasks: [[Int]]) {
        let taskItems = tasks.map { Task(userID: $0[0], taskID: $0[1], priority: $0[2]) }
        for t in taskItems {
            taskMap[t.taskID] = t
            heap.insert(t)
        }
    }
    
    func add(_ userId: Int, _ taskId: Int, _ priority: Int) {
        let newTask = Task(userID: userId, taskID: taskId, priority: priority)
        taskMap[taskId] = newTask
        heap.insert(newTask)
    }
    
    func edit(_ taskId: Int, _ newPriority: Int) {
        guard let task = taskMap[taskId] else { return }
        let edited = Task(userID: task.userID, taskID: taskId, priority: newPriority)
        taskMap[taskId] = edited
        heap.insert(edited)
    }
    
    func rmv(_ taskId: Int) {
        taskMap[taskId] = nil
    }
    
    func execTop() -> Int {
        while let taskAtTop = heap.max {
            if taskMap[taskAtTop.taskID] != taskAtTop {
                heap.popMax()
            } else {
                let validTask = heap.popMax()!
                taskMap[validTask.taskID] = nil
                return validTask.userID
            }
        }

        return -1
    }
}

/**
 * Your TaskManager object will be instantiated and called as such:
 * let obj = TaskManager(tasks)
 * obj.add(userId, taskId, priority)
 * obj.edit(taskId, newPriority)
 * obj.rmv(taskId)
 * let ret_4: Int = obj.execTop()
 */