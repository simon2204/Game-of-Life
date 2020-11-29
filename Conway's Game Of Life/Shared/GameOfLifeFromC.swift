//
//  GameOfLifeFromC.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

import Foundation

class GameOfLifeFromC {
    var timer: DispatchSourceTimer?
    var gameOfLifeShouldStart: Bool
    
    init() {
        gameOfLifeShouldStart = _main() != 0 ? true : false
    }
    
    class var rows: Int {
        Int(all_rows())
    }
    
    class var columns: Int {
        Int(all_cols())
    }
    
    func setNextGeneration() -> Bool {
        next_generation()
    }
    
    func isBitSetAtIndex(_ index: Int) -> Bool {
        is_bit_set_at_index(Int32(index))
    }
    
    func setBitAtIndex(_ index: Int) {
        set_bit_at_index(Int32(index))
    }
    
    func deleteBitAtIndex(_ index: Int) {
        delete_bit_at_index(Int32(index))
    }
    
    func start(generationDidSet: @escaping () -> Void) {
        let queue = DispatchQueue(label: "gameOfLife", attributes: .concurrent)

        timer?.cancel()

        timer = DispatchSource.makeTimerSource(queue: queue)

        timer?.schedule(deadline: .now(), repeating: .milliseconds(350), leeway: .milliseconds(20))

        timer?.setEventHandler {
            let _ = self.setNextGeneration()
            generationDidSet()
        }
        
        if gameOfLifeShouldStart {
            timer?.resume()
        }
    }

    func stop() {
        timer?.cancel()
        timer = nil
    }
}
