//
//  GridView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 27.11.20.
//

import SwiftUI

struct GridView: View {
    var strokeColor: Color
    var lineWidth: CGFloat
    var rect: CGSize
    var gridInformation: (GridInformation) -> Void
    
    init(strokeColor: Color = .gray, lineWidth: CGFloat = 0.25, rect: CGSize = CGSize(width: 10, height: 10), gridInformation: @escaping (GridInformation) -> Void) {
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.rect = rect
        self.gridInformation = gridInformation
    }
    
    var body: some View {
        GeometryReader { geometry -> AnyView in
            let size = geometry.size
            let rows = Int(size.height / rect.height)
            let columns = Int(size.width / rect.width)
            let gridInformation = GridInformation(size: size, rows: rows, columns: columns)
            self.gridInformation(gridInformation)
            let path = Path { path in
                for x in stride(from: 0, to: size.width, by: rect.width) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                }
                for y in stride(from: 0, to: size.height, by: rect.height) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                }
            }
            return AnyView(path.stroke(strokeColor, lineWidth: lineWidth))
        }
    }
    
    func onCellTap(_ cell: (Cell) -> Void) {
    }
    
    struct Cell {
        let row: Int
        let column: Int
        let pos: Int
    }
    
    struct GridInformation {
        let size: CGSize
        let rows: Int
        let columns: Int
    }
}
