//
//  GridViewModel.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

import SwiftUI

class GridViewModel: ObservableObject {
    @Published private var gridModel: GridModel = GridModel(rows: 100, columns: 100)
    
    var grid: [GridModel.Cell] {
        return gridModel.cells
    }
    
    func adjustCellSizeForGridSize(_ gridSize: CGSize) {
        gridModel.adjustCellSizeForGridSize(gridSize)
    }
    
    func setState(_ state: GridModel.Cell.State, forCellID cellID: Int) {
        gridModel.setState(state, forCellID: cellID)
    }
    
    func cell(forID id: Int) -> GridModel.Cell {
        return gridModel.cell(forID: id)
    }
    
    func cellID(row: Int, column: Int) -> Int {
        return gridModel.cellID(row: row, column: column)
    }
}
