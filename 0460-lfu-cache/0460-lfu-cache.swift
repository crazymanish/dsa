class LFUCache {
    var countMap: [Int: List] = [:]
    var map: [Int: Node?] = [:]
    var minCount: Int = 0
    
    let capacity: Int
  
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        if capacity == 0 { return -1 }
        
        if let node = map[key] {
            updateNode(node)
            return node!.value
        } else {
            return -1
        }
    }
    
    func put(_ key: Int, _ value: Int) {
        if capacity == 0 { return }
        
        if let node = map[key] {
            updateNode(node)
            node!.value = value
        } else {
            if map.count == capacity {
                var list = countMap[minCount]!
                var nodeToDelete = list.tail?.previous
                list.deleteNode(nodeToDelete)
                map[nodeToDelete!.key] = nil
            }
            minCount = 1
            var node = Node(key, value)
            map[key] = node
            let list = countMap[node.count, default: List()]
            list.moveToHead(node)
            countMap[node.count] = list

            
        }
    }
    
    func updateNode(_ node: Node?) {
        var list = countMap[node!.count]!
        list.deleteNode(node)
        
        if list.count == 0 && node!.count == minCount {
            minCount += 1
        }
        node!.count += 1
        let list2 = countMap[node!.count, default: List()]
        list2.moveToHead(node)
        countMap[node!.count] = list2
    }
}

class Node {
    var previous: Node?
    var next: Node?
    var key: Int
    var value: Int
    var count: Int 
    
    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
        self.count = 1
    }
}

class List {
    var head: Node?
    var tail: Node?
    var count: Int
    
    init() {
        head = Node(-1, -1)
        tail = Node(-1, -1)
        head?.next = tail
        tail?.previous = head
        count = 0
    } 
    
    func moveToHead(_ node: Node?) {
        node?.next = head?.next
        head?.next?.previous = node
        node?.previous = head
        head?.next = node
        count += 1
    }
    
    func deleteNode(_ node: Node?) {
        node?.next?.previous = node?.previous
        node?.previous?.next = node?.next
        count -= 1
    }
}

/**
 * Your LFUCache object will be instantiated and called as such:
 * let obj = LFUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */