//
//  Array+Extension.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-03-19.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return first
        } else {
            return nil
        }
    }
}

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
