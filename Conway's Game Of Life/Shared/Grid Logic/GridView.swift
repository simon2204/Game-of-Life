//
//  GOLGridView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var gridViewModel = GridViewModel()
    
    var body: some View {
        Grid(gridViewModel.grid, gridViewModel.rows, gridViewModel.columns) { cell in
            Rectangle()
                .fill(cell.color)
                .border(Color.black, width: 0.5)
                .opacity(0.6)
                .padding(0.5)
                .onTapGesture {
                    gridViewModel.setState(cell.switchState, forCellID: cell.id)
                }
        }
    }
}

