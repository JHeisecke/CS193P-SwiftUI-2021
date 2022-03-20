//
//  Constants.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-27.
//

import SwiftUI

struct DrawingConstants {
    static let cornerRadius: CGFloat = 20
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.7
    static let fontSize: CGFloat = 32
}

struct CardConstants {
    static let color: Color = .purple
    static let undealtHeight: CGFloat = 90
    static let aspectRatio: CGFloat = 2/3
    static let undealtWidth = undealtHeight * aspectRatio
    static let totalDealDuration: Double = 2
    static let dealDuration: Double = 0.5
}
