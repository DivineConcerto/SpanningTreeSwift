//
//  CampusMapView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/19.
//

import SwiftUI
import MapKit

// 连接的线条结构体
struct LineShape: Shape {
    var from: CLLocationCoordinate2D
    var to: CLLocationCoordinate2D

    func path(in rect: CGRect) -> Path {
        let fromPoint = CGPoint(x: rect.width * CGFloat((from.longitude - rect.minX) / (rect.maxX - rect.minX)),
                                y: rect.height * CGFloat((from.latitude - rect.minY) / (rect.maxY - rect.minY)))
        let toPoint = CGPoint(x: rect.width * CGFloat((to.longitude - rect.minX) / (rect.maxX - rect.minX)),
                              y: rect.height * CGFloat((to.latitude - rect.minY) / (rect.maxY - rect.minY)))
        
        var path = Path()
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        return path
    }
}

struct CampusMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.909764, longitude: 119.522548),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    let locations: [CampusLocation]
    let edges: [Edge]
    @State private var showEdges = false
    @Binding var showLines:Bool

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Text(location.name)
                            .offset(y: -15)  // Adjust the offset as needed
                    }
                }
            }
            .overlay(drawEdges())
        }
    }
    
    func drawEdges() -> some View {
        GeometryReader { geometry in
            ZStack {
                if showLines {
                    ForEach(edges, id: \.self) { edge in
                        let start = locations[edge.u].coordinate
                        let end = locations[edge.v].coordinate
                        Path { path in
                            path.move(to: CGPoint(x: geometry.size.width * CGFloat((start.longitude - region.center.longitude) / region.span.longitudeDelta) + geometry.size.width / 2,
                                                   y: geometry.size.height * CGFloat((region.center.latitude - start.latitude) / region.span.latitudeDelta) + geometry.size.height / 2))
                            path.addLine(to: CGPoint(x: geometry.size.width * CGFloat((end.longitude - region.center.longitude) / region.span.longitudeDelta) + geometry.size.width / 2,
                                                     y: geometry.size.height * CGFloat((region.center.latitude - end.latitude) / region.span.latitudeDelta) + geometry.size.height / 2))
                        }
                        .stroke(Color.red)
                    }
                }
            }
        }
    }
}

//#Preview {
//    CampusMapView()
//}
