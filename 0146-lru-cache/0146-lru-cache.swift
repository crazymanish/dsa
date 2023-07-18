class LRUCache {
    private var map = [Int: DLLNode]()
    private var capacity: Int
    private var dll = DLL()
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        // If key present in the map move the node to the front
        // and return the value
        if let node = map[key] {
            dll.moveToHead(node)
            return node.val
        }
        
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = map[key] {
            // Already in the map so this is just an value update
            node.val = value
            dll.moveToHead(node)
        } else {
            // An new node is added
            let newNode = DLLNode(key,value)
            
            dll.moveToHead(newNode)
            map[key] = newNode
        }
        
        // We hit the capacity remove the last one
        if map.count > capacity {
            if let node = dll.removeFromTail() {
                map[node.key] = nil
            }
        }
    }
}

class DLLNode {
    var val: Int
    var key: Int
    var next: DLLNode?
    weak var prev: DLLNode?
    
    init(_ key: Int, _ val: Int) {
        self.key = key
        self.val = val
    }
}

class DLL {
    var head: DLLNode
    var tail: DLLNode
    
    init() {
        head = DLLNode(0,0)
        tail = DLLNode(0,0)
        
        head.next = tail
        tail.prev = head
    }
    
    func moveToHead(_ node: DLLNode) {
        // If node is already in the DLL remove it first
        if let prev = node.prev, let next = node.next {
            prev.next = next
            next.prev = prev
        }
        
        // Making connections between the node and the node before head
        node.next = head.next
        head.next?.prev = node
        
        // Adding connections between head and the node
        head.next = node
        node.prev = head
    }
    
    func removeFromTail() -> DLLNode? {
        // If the list is empty return nil
        if tail.prev === head {
            return nil
        }
        
        // Remove the node by connecting tail and node.prev
        let node = tail.prev
        node?.prev?.next = tail
        tail.prev = node?.prev
        
        node?.next = nil
        node?.prev = nil
        
        return node
    }
    
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */