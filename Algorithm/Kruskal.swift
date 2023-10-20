//
//  Kruskal.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import Foundation

struct Kruskal {
    static func minimumSpanningTree(matrix: [[Double]]) -> [Edge] {
        var edges = [Edge]()
        let nodesCount = matrix.count
        for i in 0..<nodesCount {
            for j in i+1..<nodesCount {
                if matrix[i][j] != 9999 {
                    edges.append(Edge(u: i, v: j, weight: Double(matrix[i][j])))
                }
            }
        }
        edges.sort(by: { $0.weight < $1.weight })

        var unionFind = UnionFind(count: nodesCount)
        var result = [Edge]()
        for edge in edges {
            if unionFind.find(edge.u) != unionFind.find(edge.v) {
                result.append(edge)
                unionFind.union(edge.u, edge.v)
            }
        }
        print("\(result)")
        return result
    }
}
