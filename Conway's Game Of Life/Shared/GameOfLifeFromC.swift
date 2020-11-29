//
//  GameOfLifeFromC.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

import Foundation

class GameOfLifeFromC {
    var timer: DispatchSourceTimer?
    
    init() {
        let glider =
        "0000000100" +
        "0000000101" +
        "0010000110" +
        "0010100000" +
        "0011000000" +
        "0000000000" +
        "0000000000" +
        "0000000000" +
        "0000000000" +
        "0000000000"
        
//        let sonne =
//        "0001100000" +
//        "0010010000" +
//        "0100001000" +
//        "1000000100" +
//        "1000000100" +
//        "0100001000" +
//        "0010010000" +
//        "0001100000" +
//        "0000000000" +
//        "0000000000"
        
        set_generation_from_string(glider.makeCString())
        game_of_life(5)
    }
    
    class var rows: Int {
        Int(all_rows())
    }
    
    class var columns: Int {
        Int(all_cols())
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

        timer?.resume()
    }

    func stop() {
        timer?.cancel()
        timer = nil
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
}
