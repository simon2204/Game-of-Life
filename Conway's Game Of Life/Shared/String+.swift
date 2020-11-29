//
//  String+.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

import Foundation

extension String {
    func makeCString() -> UnsafeMutablePointer<Int8> {
        let count = self.utf8.count + 1
        let result = UnsafeMutablePointer<Int8>.allocate(capacity: count)
        self.withCString { (baseAddress) in
            // func initialize(from: UnsafePointer<Pointee>, count: Int)
            result.initialize(from: baseAddress, count: count)
        }
        return result
    }
}
