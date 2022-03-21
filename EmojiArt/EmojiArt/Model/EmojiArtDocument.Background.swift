//
//  EmojiArt.Background.swift
//  EmojiArt
//
//  Created by Javier Heisecke on 2022-03-15.
//

import Foundation

extension EmojiArtDocument {
    enum Background {
        case blank
        case url(URL)
        case imageData(Data)
        
        var url: URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data): return data
            default: return  nil
            }
        }
    }
}
