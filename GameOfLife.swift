//
//  GameOfLife.swift
//  Conway's Game of Life
//
//  Created by Simon Schöpke on 24.11.20.
//

import Foundation

class GameOfLife {
    private var generation: [UInt8]
    private var generationCopy: [UInt8]!
    private var segments: Int
    private let columns: Int
    private let rows: Int
    private var size: Int
    
    var timer: DispatchSourceTimer?
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        size = rows * columns
        segments = size / 8 + 1
        generation = Array(repeating: 0, count: segments)
    }
    
    init(_ firstGeneration: [String]) {
        columns = firstGeneration.first!.count
        rows = firstGeneration.count
        size = columns * rows
        segments = size / 8 + 1
        generation = Array(repeating: 0, count: segments)
        setGenerationFromString(firstGeneration)
    }
    
    func start(generationDidSet: @escaping () -> Void) {
        let queue = DispatchQueue(label: "gameOfLife", attributes: .concurrent)

        timer?.cancel()

        timer = DispatchSource.makeTimerSource(queue: queue)

        timer?.schedule(deadline: .now(), repeating: .milliseconds(350), leeway: .milliseconds(20))

        timer?.setEventHandler {
            let _ = self.setNextGeneration()
            generationDidSet()
//            if !nextGenerationDidSet { self.stop() }
        }

        timer?.resume()
    }

    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    func isBitSetAtIndex(_ index: Int) -> Bool {
        return isBitSetAtIndex(index, for: generation)
    }
    
    func setNextGeneration() -> Bool {
        var didMutate = false
        var neighbourCount: Int
        generationCopy = generation
        for index in 0..<size {
            neighbourCount = neighboursCountFromCenter(index, for: generationCopy)
            if isBitSetAtIndex(index, for: generationCopy) {
                if neighbourCount < 2 || neighbourCount > 3 {
                    deleteBitAtIndex(index, for: &generation)
                    didMutate = true
                }
            } else {
                if neighbourCount == 3 {
                    setBitAtIndex(index, for: &generation)
                    didMutate = true
                }
            }
        }
        return didMutate
    }
    
    private func setGenerationFromString(_ generation: [String]) {
        var index = 0
        for string in generation {
            for char in string {
                if char == "1" {
                    setBitAtIndex(index, for: &self.generation)
                }
                index += 1
            }
        }
    }
    
    func deleteBitAtIndex(_ index: Int) {
        deleteBitAtIndex(index, for: &generation)
    }
    
    func setBitAtIndex(_ index: Int) {
        setBitAtIndex(index, for: &generation)
    }
    
    private func deleteBitAtIndex(_ index: Int, for generation: inout [UInt8]) {
        guard let (segment, element) = indexToSegmentAndElement(index)
        else { return }
        generation[segment] &= ~(0x80 >> element)
    }
    
    private func setBitAtIndex(_ index: Int, for generation: inout [UInt8]) {
        guard let (segment, element) = indexToSegmentAndElement(index)
        else { return }
        generation[segment] |= 0x80 >> element
    }
    
    private func isBitSetAtIndex(_ index: Int, for generation: [UInt8]) -> Bool {
        guard let (segment, element) = indexToSegmentAndElement(index)
        else { return false }
        return ((0x80 >> element) & generation[segment]) > 0
    }
    
    private func neighboursCountFromCenter(_ index: Int, for generation: [UInt8]) -> Int {
        return Neighbour.allCases.reduce(0) {
            $0 + isBitSetAtIndex(indexForNeighbour($1, fromCenter: index), for: generation).intValue
        }
    }
    
    private func indexForNeighbour(_ neighbour: Neighbour, fromCenter index: Int) -> Int {
        var (row, column) = indexToRowAndColumn(index)
        switch neighbour {
        case .topLeft:
            row -= 1; column -= 1
        case .topRight:
            row -= 1; column += 1
        case .bottomLeft:
            row += 1; column -= 1
        case .bottomRight:
            row += 1; column += 1
        case .left:
            column -= 1
        case .right:
            column += 1
        case .top:
            row -= 1
        case .bottom:
            row += 1
        }
        return rowAndColumnToIndex(row, column)
    }
    
    private func indexToRowAndColumn(_ index: Int) -> (row: Int, column: Int) {
        return (index / columns, index % columns)
    }
    
    private func rowAndColumnToIndex(_ row: Int, _ column: Int) -> Int {
        return row * columns + column
    }
    
    private func indexToSegmentAndElement(_ index: Int) -> (segment: Int, element: Int)? {
        guard index >= 0 && index < size else { return nil }
        return (index / 8, index % 8)
    }
    
    func printGeneration() {
        for _ in 0..<columns {
            print("+---", terminator: "")
        }
        
        if size > 0 {
            print("+");
        }
        
        for i in 0..<rows
        {
            for j in 0..<columns {
                print("| \(charInGeneration(row: i, column: j)) ", terminator: "")
            }
            print("|")
            
            for _ in 0..<columns
            {
                print("+---", terminator: "");
            }
            print("+");
        }
    }
    
    private func charInGeneration(row: Int, column: Int) -> Character {
        return isBitSetAtIndex(rowAndColumnToIndex(row, column), for: generation).charValue
    }
    
    private enum Neighbour: CaseIterable {
        case topLeft, topRight
        case bottomLeft, bottomRight
        case left, right
        case top, bottom
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
    
    var charValue: Character {
        return self ? "o" : " "
    }
}
