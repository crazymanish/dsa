class AllOne {
	private var keyNodes = [String: Node]()
	private var head: Node? = Node()
	private var tail: Node? = Node()

	init() {
		head?.next = tail
		tail?.prev = head
	}

	func inc(_ key: String) {
		let oldNode = keyNodes[key]
		let newValue = (oldNode?.value ?? 0) + 1

		var newNode: Node?
		if let node = (oldNode ?? head)?.next, node.value == newValue {
			newNode = node
		} else {
			newNode = Node()
			newNode?.value = newValue
			(oldNode ?? head)?.insertAfter(newNode)
		}

		update(key, oldNode, newNode)
	}

	func dec(_ key: String) {
		guard let oldNode = keyNodes[key] else { return }
		let newValue = oldNode.value - 1

		var newNode: Node?
		if let node = oldNode.prev, node.value == newValue {
			newNode = node
		} else if newValue > 0 {
			newNode = Node()
			newNode?.value = newValue
			oldNode.prev?.insertAfter(newNode)
		}

		update(key, oldNode, newNode)
	}

	func getMaxKey() -> String {
		return tail?.prev?.keys.first ?? ""
	}

	func getMinKey() -> String {
		return head?.next?.keys.first ?? ""
	}

	private func update(_ key: String, _ oldNode: Node?, _ newNode: Node?) {
		newNode?.keys.insert(key)
		keyNodes[key] = newNode

		oldNode?.keys.remove(key)
		if oldNode?.keys.isEmpty == true {
			oldNode?.remove()
		}
	}
}

private class Node {
	var value = -1
	var keys = Set<String>()
	var next: Node?
	var prev: Node?

	func insertAfter(_ newNode: Node?) {
		let after = self.next
		self.next = newNode
		newNode?.prev = self
		newNode?.next = after
		after?.prev = newNode
	}

	func remove() {
		let before = self.prev
		let after = self.next
		before?.next = after
		after?.prev = before
	}
}

/**
 * Your AllOne object will be instantiated and called as such:
 * let obj = AllOne()
 * obj.inc(key)
 * obj.dec(key)
 * let ret_3: String = obj.getMaxKey()
 * let ret_4: String = obj.getMinKey()
 */