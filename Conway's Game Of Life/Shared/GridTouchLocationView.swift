//
//  GridTouchLocationView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 27.11.20.
//

import SwiftUI

struct GridTouchLocationView: View {
    var lineWidth: CGFloat
    var cellSize: CGSize
    let touchLocation: (Cell) -> Void
    
    init(lineWidth: CGFloat = 0.25, cellSize: CGSize = CGSize(width: 10, height: 10), touchLocation: @escaping (Cell) -> Void) {
        self.lineWidth = lineWidth
        self.cellSize = cellSize
        self.touchLocation = touchLocation
    }
    
    var body: some View {
        var gridInfo = GridView.GridInformation()
        
        ZStack {
            NSTouchLocationView { point in
                let row = Int(point.y / gridInfo.cellSize.height)
                let column = Int(point.x / gridInfo.cellSize.width)
                let pos = row * gridInfo.columns + column
                touchLocation(Cell(row: row, column: column, pos: pos))
            }
            
            GridView(lineWidth: lineWidth, rect: cellSize) { info in
                gridInfo = info
            }
        }
    }
    
    struct Cell {
        var row: Int
        var column: Int
        var pos: Int
    }
}
