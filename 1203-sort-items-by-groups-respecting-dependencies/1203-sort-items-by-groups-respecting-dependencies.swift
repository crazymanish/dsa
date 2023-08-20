class Solution {
    func sortItems(_ n: Int, _ m: Int, _ group: [Int], _ beforeItems: [[Int]]) -> [Int] {
        // Create a separate group for each non-grouped item.
        var group = group
        var groupCount = m
        for item in group.indices {
            if group[item] == -1 {
                group[item] = groupCount
                groupCount += 1
            }
        }

        // Create a dictionary mapping group index to a set of items in that group.
        var groups: [Int: Set<Int>] = [:]
        for (item, groupIndex) in group.enumerated() {
            groups[groupIndex, default: []].insert(item)
        }

        // Calculate dependencies between groups and items within groups.
        var groupDeps: [Int: Set<Int>] = [:]
        var sortedGroupItems: [Int: [Int]] = [:]
        for (groupIndex, groupItems) in groups {
            var currentGroupDeps: Set<Int> = []
            var groupItemDeps: [Int: Set<Int>] = [:]
            for item in groupItems {
                var currentItemDeps: Set<Int> = []
                for beforeItem in beforeItems[item] {
                    let beforeItemGroup = group[beforeItem]
                    if beforeItemGroup == groupIndex {
                        // Dependency within the same group.
                        currentItemDeps.insert(beforeItem)
                    } else {
                        // Dependency on other groups.
                        currentGroupDeps.insert(beforeItemGroup)
                    }
                }
                groupItemDeps[item] = currentItemDeps
            }
            groupDeps[groupIndex] = currentGroupDeps
            let sortedCurrentGroupItems = topologicalSort(&groupItemDeps)
            if sortedCurrentGroupItems.count == groupItems.count {
                sortedGroupItems[groupIndex] = sortedCurrentGroupItems
            } else {
                // Detected cyclic dependencies.
                return []
            }
        }

        // Topologically sort groups and merge their items in order.
        return topologicalSort(&groupDeps).reduce(into: []) {
            $0 += sortedGroupItems[$1]!
        }
    }

    // Perform topological sorting on dependencies.
    func topologicalSort( _ deps: inout [Int: Set<Int>]) -> [Int] {
        // Build a dictionary mapping parent items to their child items.
        var itemToChildren: [Int: Set<Int>] = [:]
        for (item, itemDeps) in deps {
            for parent in itemDeps {
                itemToChildren[parent, default: []].insert(item)
            }
        }

        // Initialize the stack with items that have no dependencies.
        var stack: [Int] = []
        for (item, deps) in deps {
            if deps.isEmpty {
                stack.append(item)
            }
        }

        // Perform topological sorting.
        var result: [Int] = []
        while !stack.isEmpty {
            let item = stack.removeLast()
            result.append(item)
            for child in itemToChildren[item, default: []] {
                deps[child]?.remove(item)
                if deps[child]!.isEmpty {
                    stack.append(child)
                }
            }
        }

        // Return the sorted items if no cyclic dependencies exist.
        return result.count == deps.keys.count ? result : []
    }
}