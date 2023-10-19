//
//  ContentView.swift
//  SpanningTree
//
//  Created by 张炫阳 on 2023/10/18.
//

import SwiftUI

struct ContentView: View {
    @State private var matrix: [[Int]] = []
    @State private var result: [Edge] = []
    @State private var isDataLoaded: Bool = false
    @State private var isLayoutComputed: Bool = false

    
    var body: some View {
        VStack {
            // 加载数据按钮
            Button("加载数据") {
                loadData()
            }
            .disabled(isDataLoaded)  // 如果数据已加载，禁用按钮
            
            // 计算最优布局按钮
            HStack {
                Button("使用Prim算法查找最小生成树") {
                    findOptimalLayout()
                }
                .disabled(!isDataLoaded)
                Button("使用Kruskal算法查找最小生成树"){
                    self.result = Kruskal.minimumSpanningTree(matrix: self.matrix)
                    self.isLayoutComputed = true
                }.disabled(!isDataLoaded)
            }  // 如果数据未加载，禁用按钮
            
            if isDataLoaded {
                Text("数据加载成功")
            } else {
                Text("数据未加载")
            }
            
            if isLayoutComputed {
                            TabView {
                                OriginalGraphView(matrix: matrix)
                                    .tabItem {
                                        Text("原图")
                                            .padding()
                                    }
                                
                                ResultGraphView(result: result, matrix: matrix)
                                    .tabItem {
                                        Text("结果图")
                                    }
                            }
                            .frame(height: 300)  // 根据需要调整高度
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
}



#Preview {
    ContentView()
}
