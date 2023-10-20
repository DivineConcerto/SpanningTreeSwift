//
//  DataLoader.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import Foundation
import Foundation

class DataLoader {
    
    func loadMatrix(from fileName: String) throws -> [[Double]] {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
            throw DataLoaderError.fileNotFound
        }
        
        let data = try Data(contentsOf: fileURL)
        let matrix = try JSONDecoder().decode([[Double]].self, from: data)
        
        return matrix
    }
    
}

enum DataLoaderError: Error {
    case fileNotFound
}
