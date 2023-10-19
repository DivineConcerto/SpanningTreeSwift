//
//  ResultGraphView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//
import SwiftUI

func lerp(from: Color, to: Color, fraction: Double) -> Color {
    let fromComponents = from.components()
    let toComponents = to.components()
    let red = fromComponents.red + fraction * (toComponents.red - fromComponents.red)
    let green = fromComponents.green + fraction * (toComponents.green - fromComponents.green)
    let blue = fromComponents.blue + fraction * (toComponents.blue - fromComponents.blue)
    return Color(red: red, green: green, blue: blue)
}

extension Color {
    func components() -> (red: Double, green: Double, blue: Double) {
        let scanner = Scanner(string: description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)
        let red = Double((hexNumber & 0xff0000) >> 16) / 255.0
        let green = Double((hexNumber & 0x00ff00) >> 8) / 255.0
        let blue = Double(hexNumber & 0x0000ff) / 255.0
        return (red, green, blue)
    }
}

struct ResultGraphView: View {
    var result: [Edge]
    var matrix: [[Int]]
    let nodesCount: Int
    let startColor = Color(red: 0.0, green: 0.7, blue: 1.0)  // Light blue
    let endColor = Color(red: 1.0, green: 0.5, blue: 0.0)  // Dark orange


    init(result: [Edge], matrix: [[Int]]) {
        self.result = result
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
                            let isEdgeInResult = result.contains { edge in
                                (edge.u == i && edge.v == j) || (edge.u == j && edge.v == i)
                            }
                            let colorFraction = Double(i + j) / Double((nodesCount - 1) * 2)
                            let color = lerp(from: startColor, to: endColor, fraction: colorFraction)
                            let start = self.position(for: i, in: geometry.size)
                            let end = self.position(for: j, in: geometry.size)
                            if isEdgeInResult {
                                EdgeView(start: start, end: end, weight: matrix[i][j], color: color)
                            } else {
                                EdgeView(start: start, end: end, weight: matrix[i][j], color: .white)
                            }
                        }
                    }
                }
                // Draw nodes
                ForEach(0..<nodesCount, id: \.self) { i in
                    let isNodeInResult = result.contains { edge in
                        edge.u == i || edge.v == i
                    }
                    let colorFraction = Double(i) / Double(nodesCount - 1)
                    let color = lerp(from: startColor, to: endColor, fraction: colorFraction)
                    if isNodeInResult {
                        NodeView(number: i + 1, position: self.position(for: i, in: geometry.size), color: color)
                    } else {
                        NodeView(number: i + 1, position: self.position(for: i, in: geometry.size), color: .blue)
                    }
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
//    ResultGraphView()
//}
