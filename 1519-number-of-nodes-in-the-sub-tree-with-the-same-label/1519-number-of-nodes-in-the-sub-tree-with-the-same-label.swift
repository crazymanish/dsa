class Solution {
    func countSubTrees(_ n: Int, _ edges: [[Int]], _ labels: String) -> [Int] {
        //create a two way graph using edges
        var graph: [Int: [Int]] = [:]
        for edge in edges {
            var vertices = graph[edge.first!] ?? []
            vertices.append(edge.last!)
            graph[edge.first!] = vertices
            
            vertices = graph[edge.last!] ?? []
            vertices.append(edge.first!)
            graph[edge.last!] = vertices
        }
        
        let labelArray = Array(labels)
        
        //initialising output array with all 1
        var output = Array(repeating: 1, count: n)
        
        //initial values in hashMap are also 1. Each subtree includes its own value as well
        var hashMap: [Int: [String: Int]] = [:]
        for i in 0..<n { hashMap[i] = ["\(labelArray[i])" : 1] }
        
        //stack and visted set for DFS
        var stack = [0]
        var visited: Set<Int> = [0]
        
        while !stack.isEmpty {
        //Check if next element is present else backtrack
            if let next = graph[stack.last!]?.last {
                graph[stack.last!]?.removeLast()
                //if next element is present but it is already traversed. remove it from the graoh but don't add it in stack.
                if !visited.contains(next) {
                    stack.append(next)
                    visited.insert(next)
                }
            } else {
                //backtrack
                let childHashMap = hashMap[stack.last!] ?? [:]
                stack.removeLast()
                
                //merge child hashMap with parent hashMap
                if let stackLast = stack.last, var parentHashMap = hashMap[stackLast] {
                    for (key, value) in childHashMap {
                        if let existingValue = parentHashMap[key] {
                            parentHashMap[key] = existingValue + value
                            hashMap[stackLast] = parentHashMap
                            //if parent's label is there in the subtree also, then update the value in output array
                            if "\(labelArray[stack.last!])" == key {
                                output[stack.last!] = parentHashMap[key]!
                            }
                        } else {
                            // if parent hashMap doesn't have the value that child hashMap has the add this value in parent hashMap
                            parentHashMap[key] = value
                            hashMap[stackLast] = parentHashMap
                        }
                    }
                }
            }
        }
        
        return output
    }
}