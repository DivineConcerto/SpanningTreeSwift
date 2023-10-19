//
//  OriginalGraphView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//
import SwiftUI

struct OriginalGraphView: View {
    var matrix: [[Int]]
    let nodesCount: Int

    init(matrix: [[Int]]) {
        self.matrix = matrix
        self.nodesCount = matrix.count
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw edges
                ForEach(0..<nodesCount, id: \.self) { i in
                    ForEach(0..<nodesCount, id: \.self) { j in
                        if matrix[i][j] != Int.max {
                            let start = self.position(for: i, in: geometry.size)
                            let end = self.position(for: j, in: geometry.size)
                            EdgeView(start: start, end: end, weight: matrix[i][j])
                        }
                    }
                }
                // Draw nodes
                ForEach(0..<nodesCount, id: \.self) { i in
                    NodeView(number: i + 1, position: self.position(for: i, in: geometry.size))
                }
            }
        }
    }

    func position(for node: Int, in size: CGSize) -> CGPoint {
        let angle = 2 * Double.pi / Double(nodesCount) * Double(node)
        let radius = min(size.width, size.height) / 2.5  // Adjust radius as needed
        let x = size.width / 2 + CGFloat(cos(angle)) * radius
        let y = size.height / 2 + CGFloat(sin(angle)) * radius
        return CGPoint(x: x, y: y)
    }
}

//#Preview {
//    OriginalGraphView()
//}
