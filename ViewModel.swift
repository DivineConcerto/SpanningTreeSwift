//
//  ViewModel.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import Foundation
class ViewModel: ObservableObject {
    @Published var resultString: String = ""
    // ... rest of the existing code
    
    func loadFile(file: URL) {
        // Load the matrix from the selected file
        if let loadedMatrix = loadMatrix(from: file) {
            self.matrix = loadedMatrix
            self.nodesCount = loadedMatrix.count
        } else {
            print("Error loading matrix from file")
        }
    }
    
    func findOptimalPipelineLayout() {
        // ... rest of the existing code
        // Convert the result to a string and update resultString
        resultString = result
            .map { "Edge from \($0.u + 1) to \($0.v + 1) with weight \(matrix[$0.u][$0.v])" }
            .joined(separator: "\n")
    }
    
    // ... rest of the existing code
}

