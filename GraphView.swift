//
//  GraphView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import SwiftUI

struct GraphView: View {
    var edges: [Edge]
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw lines
                ForEach(edges, id: \.self) { edge in
                    Line(start: CGPoint(x: geometry.size.width * CGFloat(edge.u) / CGFloat(edges.count),
                                       y: geometry.size.height * CGFloat(edge.u) / CGFloat(edges.count)),
                         end: CGPoint(x: geometry.size.width * CGFloat(edge.v) / CGFloat(edges.count),
                                      y: geometry.size.height * CGFloat(edge.v) / CGFloat(edges.count)))
                        .stroke(Color.blue, lineWidth: 2)
                }
                // Draw circles
                ForEach(0..<edges.count, id: \.self) { index in
                    Circle()
                        .frame(width: 20, height: 20)
                        .position(x: geometry.size.width * CGFloat(index) / CGFloat(edges.count),
                                  y: geometry.size.height * CGFloat(index) / CGFloat(edges.count))
                }
            }
        }
    }
}

struct Line: Shape {
    var start: CGPoint
    var end: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(edges: [Edge(u: 0, v: 1, weight: 10), Edge(u: 1, v: 2, weight: 15)])
    }
}


//#Preview {
//    GraphView()
//}
