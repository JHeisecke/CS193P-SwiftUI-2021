//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by Javier Heisecke on 2022-03-14.
//

import Foundation

struct EmojiArtDocument {
    var background = Background.blank
    private(set) var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Hashable {
        let id: Int
        let text: String
        var x: Int
        var y: Int
        var size: Int
        
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }
    }
    
    init () { }
    
    private var uniqueEmojiId = 0
    mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: location.x, y: location.y, size: size))
    }
}
