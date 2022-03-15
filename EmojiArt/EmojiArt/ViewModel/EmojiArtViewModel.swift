//
//  EmojiArtViewModel.swift
//  EmojiArt
//
//  Created by Javier Heisecke on 2022-03-15.
//

import Foundation

class EmojiArtViewModel: ObservableObject {
    @Published private(set) var emojiArt: EmojiArt
    
    init() {
        emojiArt = EmojiArt()
    }
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    var background: EmojiArt.Background { emojiArt.background }
    
    // MARK: - Intents
    func setBackground() {
        
    }
    
    func addEmoji() {
        
    }
    
    func moveEmoji() {
        
    }
    
    func scaleEmoji() {
        
    }
}
