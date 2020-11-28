//
//  GridModel.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 28.11.20.
//

import SwiftUI

struct GridModel {
    var cells: [Cell]
    var lineWidth: CGFloat = 0.25
    var rows: Int
    var columns: Int
    var cellSize: CGSize
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        cells = [Cell]()
        cellSize = CGSize(width: 0, height: 0)
        addCells(rows: rows, columns: columns)
    }
    
    private mutating func addCells(rows: Int, columns: Int) {
        cells.reserveCapacity(rows * columns)
        var id = 0
        for row in 0..<rows {
            for column in 0..<columns {
                cells.append(Cell(id: id, row: row, column: column))
                id += 1
            }
        }
    }
    
    mutating func adjustCellSizeForGridSize(_ gridSize: CGSize) {
        let cellWidth = gridSize.width / CGFloat(columns)
        let cellHeight = gridSize.height / CGFloat(rows)
        cellSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    mutating func setState(_ state: Cell.State, forCellID cellID: Int) {
        cells[cellID].state = state
    }
    
    func cell(forID id: Int) -> Cell {
        return cells[id]
    }
    
    func cellID(row: Int, column: Int) -> Int {
        return row * columns + column
    }
    
    struct Cell: Identifiable {
        var id: Int
        var row: Int
        var column: Int
        var state: State = .plain
        
        var color: Color {
            switch state {
            case .alive:
                return .white
            case .dead:
                return .gray
            case .plain:
                return .clear
            }
        }
        
        enum State {
            case alive, dead, plain
        }
    }
}
