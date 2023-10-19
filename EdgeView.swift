//
//  EdgeView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import SwiftUI

struct EdgeView: View {
    var start: CGPoint
    var end: CGPoint
    var weight: Int
    var color: Color = .blue
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: start)
                path.addLine(to: end)
            }
            .stroke(color, lineWidth: 2)
            Text("\(weight)")
                .position(x: (start.x + end.x) / 2, y: (start.y + end.y) / 2)
        }
    }
}

//#Preview {
//    EdgeView()
//}
