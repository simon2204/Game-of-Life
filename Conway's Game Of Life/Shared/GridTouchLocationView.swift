//
//  GridTouchLocationView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 27.11.20.
//

import SwiftUI

struct GridTouchLocationView: View {
    var lineWidth: CGFloat = 0.25
    var cellSize: CGSize = CGSize(width: 10, height: 10)
    let touchLocation: (Cell) -> Void
    
    var body: some View {
        GridView(lineWidth: lineWidth, rect: cellSize) { gridInfo in
            NSTouchLocationView { point in
                let row = Int(point.y / gridInfo.cellSize.height)
                let column = Int(point.x / gridInfo.cellSize.width)
                let pos = row * gridInfo.columns + column
                touchLocation(Cell(row: row, column: column, pos: pos))
            }
        }
    }
    
    struct Cell {
        let row: Int
        let column: Int
        let pos: Int
    }
}
