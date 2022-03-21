//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Javier Heisecke on 2022-03-14.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocumentViewModel())
        }
    }
}
