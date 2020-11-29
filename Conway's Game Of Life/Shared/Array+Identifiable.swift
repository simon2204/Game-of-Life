//
//  Array+Identifiable.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 29.11.20.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
