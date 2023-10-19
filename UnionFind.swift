//
//  UnionFind.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import Foundation

struct UnionFind {
    private var parent: [Int]
    private var rank: [Int]

    init(count: Int) {
        parent = Array(0..<count)
        rank = Array(repeating: 0, count: count)
    }

    mutating func find(_ v: Int) -> Int {
        if parent[v] != v {
            parent[v] = find(parent[v])
        }
        return parent[v]
    }

    mutating func union(_ u: Int, _ v: Int) {
        let rootU = find(u)
        let rootV = find(v)
        if rootU != rootV {
            if rank[rootU] > rank[rootV] {
                parent[rootV] = rootU
            } else if rank[rootU] < rank[rootV] {
                parent[rootU] = rootV
            } else {
                parent[rootV] = rootU
                rank[rootU] += 1
            }
        }
    }
}
