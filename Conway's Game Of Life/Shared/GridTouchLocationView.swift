//
//  GridTouchLocationView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 27.11.20.
//

import SwiftUI

struct GridTouchLocationView: View {
    let touchLocation: (Cell) -> Void
    
    init(touchLocation: @escaping (Cell) -> Void) {
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
            
            GridView { info in
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
