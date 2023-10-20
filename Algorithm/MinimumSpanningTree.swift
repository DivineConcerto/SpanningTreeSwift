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
    let weight: Double  // 权重（即距离）
    var description:String{
        return "Building \(u) to Building \(v) with Distance \(weight)"
    }
}

class MinimumSpanningTree {
    
    func primAlgorithm(matrix: [[Double]]) -> [Edge] {
        // 顶点的数量
        let numVertices = matrix.count
        // 判断是否经过该顶点
        var visited = [Bool](repeating: false, count: numVertices)
        // 存储结果的数组，每个元素是一个Edge结构体
        var result = [Edge]()
        
        // 从顶点0开始
        visited[0] = true
        
        // 遍历所有顶点，找到最小生成树的边
        for _ in 0..<numVertices - 1 {
            // 9999是最大值
            var minWeight:Double = 9999
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
            // 核心在于每次在选到最近点路之后，将终点置为已访问，下一轮从终点开始
            result.append(Edge(u: u, v: v, weight: Double(minWeight)))
        }
        
        return result
    }
}
