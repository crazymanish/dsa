class Solution {
    func numberOfGoodPaths(_ vals: [Int], _ edges: [[Int]]) -> Int {
        let nodes = vals.count
        if nodes < 2 { return nodes }
        
        var parents = (0..<nodes).map { $0 }
        func searchEdgeParent(_ edge: Int) -> Int {
            if parents[edge] == edge { return edge }
            
            parents[edge] = searchEdgeParent(parents[edge])
            return parents[edge]
        }
        
        let sortedEdges = edges
            .map { edge in [
                edge[0], 
                edge[1], 
                max(vals[edge[0]], vals[edge[1]])
            ]}
            .sorted { $0[2] < $1[2] }
        var nodeInfo = vals.map { (value: $0, count: 1) }
        var result = 0
        
        for edge in sortedEdges {
            let maximumNodeValue = edge[2]
            
            let startingNode = searchEdgeParent(edge[0])
            let endingNode = searchEdgeParent(edge[1])
            parents[endingNode] = startingNode
            
            let startingNodeInfo = nodeInfo[startingNode]
            let endpoingNodeInfo = nodeInfo[endingNode]
            
            if startingNodeInfo.value == endpoingNodeInfo.value {
                result += startingNodeInfo.count * endpoingNodeInfo.count
            }
            
            let startingNodeCount = (startingNodeInfo.value == maximumNodeValue) ? startingNodeInfo.count : 0
            let endingNodeCount = (endpoingNodeInfo.value == maximumNodeValue) ? endpoingNodeInfo.count : 0
            let nodesCount = startingNodeCount + endingNodeCount
            nodeInfo[startingNode] = (maximumNodeValue, nodesCount)
        }
        
        return result + nodes
    }
}