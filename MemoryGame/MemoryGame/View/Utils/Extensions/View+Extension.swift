//
//  View.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-27.
//

import SwiftUI

extension View {
    func cardify(isFaceUp value: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: value))
    }
}

