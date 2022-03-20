//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [MemoryCard]
    var name: String
    var color: Int
    var score = 0
    
    private var indexOfFlippedCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach{ cards[$0].isFaceUp = ( $0 == newValue) } }
    }
    
    init(theme: DeckThemes, createCardContent: (Int, DeckThemes) -> CardContent) {
        name = theme.name
        color = theme.color
        cards = [MemoryCard]()
        score = 0
        for pairIndex in 0..<theme.numberOfPairs {
            let content = createCardContent(pairIndex, theme)
            cards.append(MemoryCard(id: pairIndex*2+1, content: content))
            cards.append(MemoryCard(id: pairIndex*2, content: content))
            cards.shuffle()
        }
    }
    
    mutating func choose(_ card: MemoryCard) {
        if let chosenIndex = cards.firstIndex(matching: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let matchCardIndex = indexOfFlippedCard {
                if cards[chosenIndex].content == cards[matchCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[matchCardIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].hasBeenSeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFlippedCard = chosenIndex
            }
            cards[chosenIndex].hasBeenSeen = true
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct MemoryCard: Identifiable {
        let id: Int
        let content: CardContent
        var hasBeenSeen = false
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        // MARK: - Bonus Time
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
