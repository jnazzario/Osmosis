import Foundation

enum Suit: String, CaseIterable {
    case hearts = "♥️"
    case diamonds = "♦️"
    case clubs = "♣️"
    case spades = "♠️"
}

enum Rank: Int, CaseIterable {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

struct Card {
    let suit: Suit
    let rank: Rank
}

struct Deck {
    var cards: [Card]

    init() {
        cards = []
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                cards.append(Card(suit: suit, rank: rank))
            }
        }
        cards.shuffle()
    }
    
    mutating func drawCard() -> Card? {
        return cards.isEmpty ? nil : cards.removeLast()
    }
}

class GameState: ObservableObject {
    @Published var tableau: [[Card]] = []
    @Published var foundation: [Card] = []
    @Published var stock: [Card] = []

    init() {
        setupGame()
    }

    func setupGame() {
        let deck = Deck()
        var deckCopy = deck.cards
        
        // Create tableau with 4 piles
        for _ in 0..<4 {
            tableau.append([Card]())
            for _ in 0..<4 { // each pile gets 4 cards
                if let card = deckCopy.popLast() {
                    tableau[tableau.count - 1].append(card)
                }
            }
        }

        // Draw cards from stock
        stock = deckCopy
    }
    
    func canMoveToFoundation(_ card: Card) -> Bool {
        guard let lastFoundationCard = foundation.last else {
            return card.rank == .ace
        }
        return card.suit == lastFoundationCard.suit && card.rank.rawValue == lastFoundationCard.rank.rawValue + 1
    }
    
    func moveCardToFoundation(from tableauIndex: Int) -> Bool {
        guard let card = tableau[tableauIndex].last else { return false }
        if canMoveToFoundation(card) {
            foundation.append(card)
            tableau[tableauIndex].removeLast()
            return true
        }
        return false
    }

    func drawFromStock() -> Card? {
        return stock.isEmpty ? nil : stock.removeLast()
    }
}
