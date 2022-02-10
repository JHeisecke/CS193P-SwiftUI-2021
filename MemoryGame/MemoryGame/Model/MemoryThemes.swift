//
//  CardThemes.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-10.
//

import Foundation

enum MemoryThemes {
    case vehicles
    case animals
    case foods
    case people
    case flags
    case objects
    
    var color: Int {
        switch self {
        case .vehicles:
            return 0xffffcc
        case .animals:
            return 0xccff99
        case .foods:
            return 0xff9966
        case .people:
            return 0xffcc99
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
        case .flags:
            return ["🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇪🇺", "🇪🇹", "🇸🇿", "🇪🇪", "🇪🇷", "🇬🇶", "🇸🇻", "🇪🇬", "🇪🇨", "🇩🇴"]
        case .objects:
            return ["📷", "📸", "📹", "🎥", "📽", "🎞", "📞", "☎️", "📟", "📠", "📺", "📻", "🎙", "📀", "💾", "⌚️", "📱"]
        }
    }
    
    var name: String {
        switch self {
        case .vehicles:
            return "Vehicles"
        case .animals:
            return "Animals"
        case .foods:
            return "Foods"
        case .people:
            return "People"
        case .flags:
            return "Flags"
        case .objects:
            return "Objects"
        }
    }
    
    var numberOfPairs: Int {
        switch self {
        case .vehicles:
            return 9
        case .animals:
            return 8
        case .foods:
            return 11
        case .people:
            return 10
        case .flags:
            return 15
        case .objects:
            return 12
        }
    }
    
    static var randomOption: MemoryThemes {
        return [.foods, .animals, .vehicles, .people, .flags, .objects].shuffled()[0]
    }
}
