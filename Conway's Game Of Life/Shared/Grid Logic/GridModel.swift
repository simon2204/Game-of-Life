//
//  GridModel.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 28.11.20.
//

import SwiftUI

struct GridModel {
    var cells: [Cell]
    var rows: Int
    var columns: Int
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        cells = [Cell]()
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
        var state: State = .dead
        
        var color: Color {
            switch state {
            case .alive:
                return .white
            case .dead:
                return .init(.displayP3, white: 1, opacity: 0.00001)
            }
        }
        
        var switchState: State {
            switch state {
            case .alive:
                return .dead
            case .dead:
                return .alive
            }
        }
        
        enum State {
            case alive, dead
        }
    }
}
