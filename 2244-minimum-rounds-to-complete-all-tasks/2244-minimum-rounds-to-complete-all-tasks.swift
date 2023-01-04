class Solution {
    func minimumRounds(_ tasks: [Int]) -> Int {
        if tasks.count == 0 { return 0 }
        
        var tasksHashMap: [Int : Int] = [:]
        for task in tasks{
          tasksHashMap[task] = tasksHashMap[task, default:0] + 1  
        }
        
        var minimumRoundsRequired = 0
        for (_, taskCount) in tasksHashMap {
            if taskCount == 1 { return -1 }
            
            let remaining = taskCount/3
            minimumRoundsRequired += (taskCount % 3 == 0) ? remaining : (remaining+1)
        }
        
        return minimumRoundsRequired
    }
}