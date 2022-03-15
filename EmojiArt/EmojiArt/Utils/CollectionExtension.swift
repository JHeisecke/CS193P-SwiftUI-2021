//
//  CollectionExtension.swift
//  EmojiArt
//
//  Created by Javier Heisecke on 2022-03-15.
//

import Foundation

extension Collection where Element: Identifiable {
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
}
