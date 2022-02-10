//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

struct MemoryGame {
    private(set) var deck: Deck
    private(set) var points: Int
    private var indexOfFlippedCard: Int?

    init (theme: MemoryThemes, numberOfPairs: Int, createCardContent: @escaping (Int, MemoryThemes) -> String) {
        self.points = 0
        self.deck = Deck(theme: theme, numberOfPairs: numberOfPairs, createCardContent: createCardContent)
    }
    
    mutating func choose(_ card: Deck.Card) {
        if let chosenIndex = deck.cards.firstIndex(where: { $0.id == card.id}),
           !deck.cards[chosenIndex].isFaceUp,
           !deck.cards[chosenIndex].isMatched
        {
            if let matchCardIndex = indexOfFlippedCard {
                if deck.cards[chosenIndex].content == deck.cards[matchCardIndex].content {
                    deck.cards[chosenIndex].isMatched = true
                    deck.cards[matchCardIndex].isMatched = true
                    points += 2
                    indexOfFlippedCard = nil
                } else {
                    if deck.cards[chosenIndex].hasBeenSeen {
                        points -= 1
                    }
                    indexOfFlippedCard = nil
                }
            } else {
                for index in deck.cards.indices {
                    if !deck.cards[index].isMatched {
                        deck.cards[index].isFaceUp = false
                    }
                }
                indexOfFlippedCard = chosenIndex
            }
            deck.cards[chosenIndex].isFaceUp.toggle()
            deck.cards[chosenIndex].hasBeenSeen = true
        }
    }
    
    var cards: [Deck.Card] {
        return deck.cards
    }
    
    var name: String {
        return deck.name
    }
    
    struct Deck {
        var name: String
        var cards: [Card]
        var color: Int
        var numberOfPairs: Int

        init(theme: MemoryThemes, numberOfPairs: Int, createCardContent: (Int, MemoryThemes) -> String) {
            self.name = theme.name
            self.color = theme.color
            self.numberOfPairs = numberOfPairs
            
            var cards = [Card]()
            let pairs = numberOfPairs > theme.numberOfPairs ? theme.numberOfPairs : numberOfPairs
            for pairIndex in 0..<pairs {
                let content = createCardContent(pairIndex, theme)
                cards.append(Card(id: pairIndex*2+1, content: content))
                cards.append(Card(id: pairIndex*2, content: content))
            }
            
            self.cards = cards.shuffled()

        }
        
        struct Card: Identifiable {
            var id: Int
            var content: String
            var isFaceUp = false
            var isMatched = false
            var hasBeenSeen = false
        }
    }
}


