//
//  ContentView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import SwiftUI
import MapKit

// 定义学校内建筑的地点
struct CampusLocation: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


struct ContentView: View {
    // 接受传入矩阵的数据
    @State private var matrix: [[Double]] = []
    // 接受计算后结果的数据
    @State private var result: [Edge] = []
    // 用来判断Data是否载入成功
    @State private var isDataLoaded: Bool = false
    // 判断是否计算完毕
    @State private var isLayoutComputed: Bool = false
    // 判断是否显示线条
    @State private var showLines:Bool = false
    // 用来返回结果栏显示的内容
    var resultDescription:String{
        guard !result.isEmpty else{
            return "当前无结果"
        }
        // 用正则表达式进行筛选
        return result.map { "\($0.u) - \($0.v): \($0.weight)" }
                              .joined(separator: "\n")
        
    }
    // 这个是各个建筑的坐标数据
    let campusLocations = [
               CampusLocation(name: "里仁学院", coordinate: CLLocationCoordinate2D(latitude: 39.906375, longitude: 119.526676)),
               CampusLocation(name: "学生公寓", coordinate: CLLocationCoordinate2D(latitude: 39.910908, longitude: 119.52412)),
               CampusLocation(name: "西校区食堂", coordinate: CLLocationCoordinate2D(latitude: 39.907195, longitude: 119.521121)),
               CampusLocation(name: "西区教学楼", coordinate: CLLocationCoordinate2D(latitude: 39.909699, longitude: 119.524092)),
               CampusLocation(name: "材料学院", coordinate: CLLocationCoordinate2D(latitude: 39.908784, longitude: 119.522817)),
               CampusLocation(name: "电气学院", coordinate: CLLocationCoordinate2D(latitude: 39.909764, longitude: 119.522548)),
               CampusLocation(name: "理学院", coordinate: CLLocationCoordinate2D(latitude: 39.917206, longitude: 119.522774)),
               CampusLocation(name: "艺术学院", coordinate: CLLocationCoordinate2D(latitude: 39.914372, longitude: 119.519577)),
               CampusLocation(name: "经管学院", coordinate: CLLocationCoordinate2D(latitude: 39.91437, longitude: 119.521745)),
               CampusLocation(name: "西里西亚学院", coordinate: CLLocationCoordinate2D(latitude: 39.915957, longitude: 119.523027)),
               CampusLocation(name: "信息学院", coordinate: CLLocationCoordinate2D(latitude: 39.9174, longitude: 119.520585)),
               ]

    var body: some View {
            HStack {
                // 左侧
                VStack {
                    
                    Button("加载数据") {
                        loadData()
                    }
                    .disabled(isDataLoaded)
                    
                    HStack {
                        
                        Button("使用Prim算法查找最小生成树") {
                            findOptimalLayout()
                        }
                        .disabled(!isDataLoaded)
                        
                        Button("使用Kruskal算法查找最小生成树") {
                            self.result = Kruskal.minimumSpanningTree(matrix: self.matrix)
                            self.isLayoutComputed = true
                        }
                        .disabled(!isDataLoaded)
                    }
                
                    if isDataLoaded {
                        Text("数据加载成功")
                    } else {
                        Text("数据未加载")
                    }
                    
                    Button(action: {showLines.toggle()}, label: {
                        Text(showLines ? "隐藏线条" : "显示线条")
                    }).disabled(!isLayoutComputed)

                    Divider()
                    
                    VStack {
                        Text("结果:")
                        ScrollView {
                            Text(resultDescription)
                                .font(.system(.body, design: .monospaced))
                                .padding()
                        }
                    }
                }
                .padding()
                .frame(minWidth: 200)
                
                // 右侧
                if isLayoutComputed {
                    CampusMapView(locations: campusLocations, edges: result,showLines:$showLines)
                        .edgesIgnoringSafeArea(.all)
                }
        }
    }
    

    // 加载数据
    func loadData() {
        let loader = DataLoader()
        do {
            matrix = try loader.loadMatrix(from: "data")
            isDataLoaded = true
            print("Data loaded successfully.")
        } catch {
            print("Error loading data: \(error)")
        }
    }

    // 计算最优布局
    func findOptimalLayout() {
        print("开始计算")
        let mst = MinimumSpanningTree()
        result = mst.primAlgorithm(matrix: matrix)
        print(result)
        isLayoutComputed = true  // 更新布局计算状态
    }
    
    func computeMinimumSpanningTree(){
        isLayoutComputed = true
    }
}

#Preview {
    ContentView()
}
