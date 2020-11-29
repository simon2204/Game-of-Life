//
//  GridViewModel.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

import SwiftUI

class GridViewModel: ObservableObject {
    @Published private var gridModel: GridModel
    private let gameOfLife: GameOfLifeFromC
    
    init() {
        gridModel = GridModel(rows: GameOfLifeFromC.rows, columns: GameOfLifeFromC.columns)
        gameOfLife = GameOfLifeFromC()
        
        grid.forEach { cell in
            let state: GridModel.Cell.State = gameOfLife.isBitSetAtIndex(cell.id) ? .alive : .dead
            DispatchQueue.main.async {
                self.setState(state, forCellID: cell.id)
            }
        }
        
        gameOfLife.start {
            self.grid.forEach { cell in
                let state: GridModel.Cell.State = self.gameOfLife.isBitSetAtIndex(cell.id) ? .alive : .dead
                DispatchQueue.main.async {
                    self.setState(state, forCellID: cell.id)
                }
            }
        }
    }
    
    var grid: [GridModel.Cell] {
        gridModel.cells
    }
    
    var rows: Int {
        gridModel.rows
    }
    
    var columns: Int {
        gridModel.columns
    }
    
    func setState(_ state: GridModel.Cell.State, forCellID cellID: Int) {
        gridModel.setState(state, forCellID: cellID)
        if state == .alive {
            gameOfLife.setBitAtIndex(cellID)
        } else {
            gameOfLife.deleteBitAtIndex(cellID)
        }
    }
    
    func cell(forID id: Int) -> GridModel.Cell {
        gridModel.cell(forID: id)
    }
    
    func cellID(row: Int, column: Int) -> Int {
        gridModel.cellID(row: row, column: column)
    }
}
