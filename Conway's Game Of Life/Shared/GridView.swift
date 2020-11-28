//
//  GridView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 27.11.20.
//

import SwiftUI

struct GridView<UnderlyingView: View>: View {
    var lineWidth: CGFloat
    var cellSize: CGSize
    var gridInformation: (GridInformation) -> UnderlyingView
    
    init(strokeColor: Color = .gray,
         lineWidth: CGFloat = 0.25,
         rect: CGSize = CGSize(width: 10, height: 10),
         gridInformation: @escaping (GridInformation) -> UnderlyingView) {
        self.lineWidth = lineWidth
        self.cellSize = rect
        self.gridInformation = gridInformation
    }
    
    var body: some View {
        GeometryReader { geometry -> AnyView in
            let size = geometry.size
            let rows = Int(size.height / cellSize.height) + 1
            let columns = Int(size.width / cellSize.width) + 1
            let gridInformation = GridInformation(size: size, rows: rows, columns: columns, cellSize: cellSize)
            let path = Path { path in
                for x in stride(from: 0, to: size.width, by: cellSize.width) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                }
                for y in stride(from: 0, to: size.height, by: cellSize.height) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                }
            }
            
            return AnyView(ZStack {
                self.gridInformation(gridInformation)
                path.stroke(lineWidth: lineWidth)
            })
        }
    }
    
    struct GridInformation {
        var size: CGSize = .zero
        var rows: Int = 0
        var columns: Int = 0
        var cellSize: CGSize = .zero
    }
}
