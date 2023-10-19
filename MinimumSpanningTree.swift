//
//  MinimumSpanningTree.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//


import Foundation


struct Edge: Hashable {
    let u: Int  // 起点
    let v: Int  // 终点
    let weight: Int  // 权重（即距离）
    var description:String{
        return "Building \(u) to Building \(v) with Distance \(weight)"
    }
}

class MinimumSpanningTree {
    
    func primAlgorithm(matrix: [[Int]]) -> [Edge] {
        let numVertices = matrix.count
        var visited = [Bool](repeating: false, count: numVertices)
        var result = [Edge]()  // 存储结果的数组，每个元素是一个Edge结构体
        
        // 从顶点0开始
        visited[0] = true
        
        // 遍历所有顶点，找到最小生成树的边
        for _ in 0..<numVertices - 1 {
            var minWeight = Int.max
            var u = 0
            var v = 0
            
            for i in 0..<numVertices {
                if visited[i] {
                    for j in 0..<numVertices {
                        if !visited[j] && matrix[i][j] > 0 && matrix[i][j] < minWeight {
                            minWeight = matrix[i][j]
                            u = i
                            v = j
                        }
                    }
                }
            }
            
            visited[v] = true
            result.append(Edge(u: u, v: v, weight: minWeight))
        }
        
        return result
    }
}
