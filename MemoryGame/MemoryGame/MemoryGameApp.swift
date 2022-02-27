//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-03.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    var body: some Scene {
        WindowGroup {
            MemoryGameView(viewModel: MemoryGameViewModel())
        }
    }
}
