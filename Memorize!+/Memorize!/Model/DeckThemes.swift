//
//  DeckThemes.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-03-20.
//

import Foundation

enum DeckThemes {
    case vehicles
    case animals
    case foods
    case people
    case flags
    case objects
    
    var color: Int {
        switch self {
        case .vehicles:
            return 0xccff33
        case .animals:
            return 0xccff99
        case .foods:
            return 0xff9966
        case .people:
            return 0xffcc00
        case .flags:
            return 0xcc0000
        case .objects:
            return 0xff6600
        }
    }
    
    var deck: [String] {
        switch self {
        case .vehicles:
            return ["🚙", "🚎", "🚗", "🚕", "🚌", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻"]
        case .animals:
            return ["🐒", "🦅", "🦫", "🦥", "🐿", "🦔", "🦤", "🦁", "🐯"]
        case .foods:
            return ["🧋", "🥤", "🍰", "🧅", "🥔", "🥐", "🍿", "🍖", "🍗", "🥩", "🍔", "🍟", "🍕"]
        case .people:
            return ["👶🏻", "🧒🏻", "👦🏽", "👧🏾", "👨🏿‍🦰", "👱🏽‍♀️", "👩🏼‍🦳", "👩🏼‍🦱", "👳🏿", "👮🏾", "👷🏻", "🧕🏻"]
        case .objects:
            return ["📷", "📸", "📹", "🎥", "📽", "🎞", "📞", "☎️", "📟", "📠", "📺", "📻", "🎙", "📀", "💾", "⌚️", "📱"]
        case .flags:
            return ["🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇪🇺", "🇪🇹", "🇸🇿", "🇪🇪", "🇪🇷", "🇬🇶", "🇸🇻", "🇪🇬", "🇪🇨", "🇩🇴"]
        }
    }
    
    var name: String {
        switch self {
        case .vehicles:
            return String(localized: "Vehicles")
        case .animals:
            return String(localized: "Animals")
        case .foods:
            return String(localized: "Foods")
        case .people:
            return String(localized: "People")
        case .flags:
            return String(localized: "Flags")
        case .objects:
            return String(localized: "Objects")
        }
    }
    
    var numberOfPairs: Int {
        switch self {
        case .animals:
            return 8
        case .vehicles:
            return 9
        case .people:
            return 10
        case .foods:
            return 11
        case .objects:
            return 12
        case .flags:
            return 21
        }
    }
    
    static var allOptions: [DeckThemes] {
        return [.animals, .vehicles, .people, .foods, .objects, .flags]
    }
    
    static var randomOption: DeckThemes {
        return allOptions.shuffled()[0]
    }
}
