//
//  DataLoader.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import Foundation

class DataLoader {
    
    func loadMatrix(from fileName: String) throws -> [[Int]] {
        // 注意这里的 withExtension 参数应设置为 "txt"
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
            throw NSError(domain: "File not found", code: 1, userInfo: nil)
        }
        
        // ... 其余代码保持不变

        
        let data = try String(contentsOf: fileURL, encoding: .utf8)
        let lines = data.split(separator: "\n").map { String($0) }
        let matrix = lines.map { line in
            line.split(separator: " ").map { Int($0)! }
        }
        
        return matrix
    }
    
}

enum DataLoaderError: Error {
    case fileNotFound
}
