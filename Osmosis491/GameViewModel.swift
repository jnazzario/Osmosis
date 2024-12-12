import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var deck: [Card] = []                                        // Deck of cards used in the game
    @Published var reservePiles: [[Card]] = [[], [], [], []]                // Reserve piles
    @Published var foundations: [[Card]] = [[], [], [], []]                 // Foundations
    @Published var foundationRevealed: [Bool] = [true, false, false, false] // All foundations are revealed from the start
    @Published var stockPile: [Card] = []                                   // Stock pile
    @Published var score: Int = 0                                           // Player score
    @Published var foundationRank: Card.Rank? = nil                         // Track the rank of the first foundation card
    @Published var gameWon: Bool = false                                    // Track if game is won
    private var undoStack: [GameState] = []                                 // Stack for undo states
    
    init() {
        startNewGame() // Start a new game when the view model is initialized
    }
    
    // Represents the full game state
    private struct GameState {
        var deck: [Card]
        var reservePiles: [[Card]]
        var foundations: [[Card]]
        var stockPile: [Card]
        var score: Int
    }
    
    private func createDeck() -> [Card] {
        var deck: [Card] = []
        for suit in Card.Suit.allCases {
            for rank in Card.Rank.allCases {
                deck.append(Card(suit: suit, rank: rank))
            }
        }
        return deck
    }
    
    private func saveState() {
        // Save the current game state to the undo stack
        let state = GameState(deck: deck, reservePiles: reservePiles, foundations: foundations, stockPile: stockPile, score: score)
        undoStack.append(state)
    }
    
    func undoLastMove() {
        // Revert to the previous game state if available
        guard !undoStack.isEmpty else {
            print("No moves to undo.")
            return
        }
        
        let previousState = undoStack.removeLast()
        deck = previousState.deck
        reservePiles = previousState.reservePiles
        foundations = previousState.foundations
        stockPile = previousState.stockPile
        score -= 8 // Subtract 8 points for using undo
        
        objectWillChange.send() // Notify views of changes
    }
    
    func checkForWin() {
        // Check if all foundation piles are full (or meet the win condition)
        gameWon = foundations.allSatisfy { foundation in
            foundation.count == 13 // A full pile has 13 cards
        }
    }
    
    func startNewGame() {
        undoStack.removeAll()
        deck = createDeck().shuffled()
        
        // Reset foundation piles
        foundations = [[], [], [], []]
        foundationRevealed = [true, false, false, false]
        
        // Reset and Distribute cards to reserve piles
        reservePiles = [[], [], [], []]
        for index in 0..<4 {
            for _ in 0..<4 {
                if let card = deck.popLast() {
                    reservePiles[index].append(card)
                }
            }
        }
        
        // Set up the first foundation
        if let firstCard = deck.popLast() {
            foundations[0].append(firstCard)
            foundationRank = firstCard.rank
            foundationRevealed = [true, false, false, false]
        }
        
        // Remaining cards go to the stock
        stockPile = deck
        score = 0
        gameWon = false
        objectWillChange.send()
    }
    
    
    func moveCard(fromReserve reserveIndex: Int, toFoundation foundationIndex: Int) {
        guard !reservePiles[reserveIndex].isEmpty else {
            print("Reserve pile \(reserveIndex) is empty.")
            return
        }

        let card = reservePiles[reserveIndex].last!

        if canMoveToFoundation(card: card, foundationIndex: foundationIndex) {
            saveState()

            print("Moving \(card.rank) of \(card.suit) to foundation \(foundationIndex)")
            reservePiles[reserveIndex].removeLast()
            foundations[foundationIndex].append(card)

            // If the foundation was empty, check if we need to reveal a new foundation
            if foundations[foundationIndex].count == 1 {
                revealNewFoundation(for: card)
            }

            score += 10
            objectWillChange.send()
        } else {
            print("Cannot move \(card.rank) of \(card.suit) to foundation \(foundationIndex)")
        }
        
        checkForWin()
    }

    
    
    func drawFromStock() {
        guard !stockPile.isEmpty else {
            print("Recycling stock pile...")
            stockPile.shuffle()
            return
            
        }
        
        saveState()
        
        let drawnCard = stockPile.removeLast()
        
        for index in 0..<foundations.count {
            if canMoveToFoundation(card: drawnCard, foundationIndex: index) {
                foundations[index].append(drawnCard)
                revealNewFoundation(for: drawnCard)
                score += 10
                objectWillChange.send()
                return
            }
        }
        
        stockPile.insert(drawnCard, at:0)
        
        print("Cannot place drawn card \(drawnCard.rank) of \(drawnCard.suit) on any foundation.")
    }
    
    
    func revealNewFoundation(for card: Card) {
        // Ensure valid foundation rank
        guard let foundationRank = foundationRank else {
            print("Foundation rank is not set.")
            return
        }

        // Check if the card matches the foundation rank and is not in an existing suit
        let existingSuits = foundations.compactMap { $0.first?.suit }
        if card.rank == foundationRank && !existingSuits.contains(card.suit) {
            // Find the next unrevealed foundation
            if let emptyFoundationIndex = foundationRevealed.firstIndex(of: false) {
                foundationRevealed[emptyFoundationIndex] = true
                foundations[emptyFoundationIndex].append(card)
                print("Revealed a new foundation pile for suit \(card.suit)")
            } else {
                print("No more foundations can be revealed.")
            }
        }
    }

    func canMoveToFoundation(card: Card, foundationIndex: Int) -> Bool {
        guard foundationIndex < foundations.count else {
            return false
        }
        
        // Check if the foundation is empty
        if foundations[foundationIndex].isEmpty {
            // A new foundation can only be started if the card matches the foundation rank
            return card.rank == foundationRank
        }
        
        // Allow adding to an existing foundation if the suits match
        let topCard = foundations[foundationIndex].last!
        return card.suit == topCard.suit
    }
    
    struct FoundationAreaView: View {
        var foundations: [[Card]]
        var onEmptyPileTap: (Int) -> Void

        var body: some View {
            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) { index in
                    if foundations[index].isEmpty {
                        EmptyPileView {
                            onEmptyPileTap(index)
                        }
                    } else {
                        FoundationView(cards: foundations[index])
                    }
                }
            }
        }
    }
    
}
