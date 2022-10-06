struct TimeMapModel {
    var value: String
    var timestamp: Int
}

class TimeMap {
   var hashMap: [String: [TimeMapModel]]
    
    init() {
        hashMap = [:]
    }
    
    func set(_ key: String, _ value: String, _ timestamp: Int) {
        let model = TimeMapModel(value: value, timestamp: timestamp)
        hashMap[key, default: []].append(model)
    }
    
    func get(_ key: String, _ timestamp: Int) -> String {
        guard let models = hashMap[key] else {
            return ""
        }
        
        guard let first = models.first, first.timestamp <= timestamp else {
            return ""
        }
        
        return binarySearch(models, timestamp)
    }
    
    private func binarySearch(_ models: [TimeMapModel], _ timestamp: Int) -> String {
        var left = 0
        var right = models.count
        var mainModel = TimeMapModel(value: "", timestamp: -1)
         
        while left < right {
             let mid = left + ((right - left) / 2)
             let model = models[mid]
             
            if model.timestamp == timestamp {
                 return model.value
             } else if model.timestamp > timestamp {
                 right = mid
             } else {
                 mainModel = model 
                 left = mid + 1
             }
         }
        
        return mainModel.value
    }
}
/**
 * Your TimeMap object will be instantiated and called as such:
 * let obj = TimeMap()
 * obj.set(key, value, timestamp)
 * let ret_2: String = obj.get(key, timestamp)
 */