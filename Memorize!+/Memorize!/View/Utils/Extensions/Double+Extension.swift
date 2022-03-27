//
//  Double+.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-03-20.
//

import Foundation

extension Double {
    func round(to precision: Int) -> Double {
        let divisor = pow(10.0, Double(precision))
        return (self * divisor).rounded() / divisor
    }
}
