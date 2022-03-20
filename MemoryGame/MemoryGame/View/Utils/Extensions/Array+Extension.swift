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
