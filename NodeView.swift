//
//  NodeView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import SwiftUI

struct NodeView: View {
    var number: Int
    var position: CGPoint
    var color: Color = .blue
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 30, height: 30)
                .position(position)
            Text("\(number)")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .position(position)
        }
    }
}

//#Preview {
//    NodeView()
//}
