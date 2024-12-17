import Foundation
import SwiftUI

//class GameViewModel: ObservableObject {
//    @Published var deck: [Card] = []                                        // Deck of cards used in the game
//    @Published var reservePiles: [[Card]] = [[], [], [], []]                // Reserve piles
//    @Published var foundations: [[Card]] = [[], [], [], []]                 // Foundations
//    @Published var foundationRevealed: [Bool] = [true, false, false, false] // All foundations are revealed from the start
//    @Published var stockPile: [Card] = []                                   // Stock pile
//    @Published var score: Int = 0                                           // Player score
//    @Published var foundationRank: Card.Rank? = nil                         // Track the rank of the first foundation card
//    @Published var gameWon: Bool = false                                    // Track if game is won
//    private var undoStack: [GameState] = []                                 // Stack for undo states
//
//    init() {
//        startNewGame() // Start a new game when the view model is initialized
//    }
//
//    // Represents the full game state
//    private struct GameState {
//        var deck: [Card]
//        var reservePiles: [[Card]]
//        var foundations: [[Card]]
//        var stockPile: [Card]
//        var score: Int
//    }
//
//    private func createDeck() -> [Card] {
//        var deck: [Card] = []
//        for suit in Card.Suit.allCases {
//            for rank in Card.Rank.allCases {
//                deck.append(Card(suit: suit, rank: rank))
//            }
//        }
//        return deck
//    }
//
//    private func saveState() {
//        // Save the current game state to the undo stack
//        let state = GameState(deck: deck, reservePiles: reservePiles, foundations: foundations, stockPile: stockPile, score: score)
//        undoStack.append(state)
//    }
//
//    func undoLastMove() {
//        // Revert to the previous game state if available
//        guard !undoStack.isEmpty else {
//            print("No moves to undo.")
//            return
//        }
//
//        let previousState = undoStack.removeLast()
//        deck = previousState.deck
//        reservePiles = previousState.reservePiles
//        foundations = previousState.foundations
//        stockPile = previousState.stockPile
//        score -= 8 // Subtract 8 points for using undo
//
//        objectWillChange.send() // Notify views of changes
//    }
//
//    func checkForWin() {
//        // Check if all foundation piles are full (or meet the win condition)
//        gameWon = foundations.allSatisfy { foundation in
//            foundation.count == 13 // A full pile has 13 cards
//        }
//    }
//
//    func startNewGame() {
//        undoStack.removeAll()
//        deck = createDeck().shuffled()
//
//        // Reset foundation piles
//        foundations = [[], [], [], []]
//        foundationRevealed = [true, false, false, false]
//
//        // Reset and Distribute cards to reserve piles
//        reservePiles = [[], [], [], []]
//        for index in 0..<4 {
//            for _ in 0..<4 {
//                if let card = deck.popLast() {
//                    reservePiles[index].append(card)
//                }
//            }
//        }
//
//        // Set up the first foundation
//        if let firstCard = deck.popLast() {
//            foundations[0].append(firstCard)
//            foundationRank = firstCard.rank
//            foundationRevealed = [true, false, false, false]
//        }
//
//        // Remaining cards go to the stock
//        stockPile = deck
//        score = 0
//        gameWon = false
//        objectWillChange.send()
//    }
//
//
//    func moveCard(fromReserve reserveIndex: Int, toFoundation foundationIndex: Int) {
//        guard !reservePiles[reserveIndex].isEmpty else {
//            print("Reserve pile \(reserveIndex) is empty.")
//            return
//        }
//
//        let card = reservePiles[reserveIndex].last!
//
//        if canMoveToFoundation(card: card, foundationIndex: foundationIndex) {
//            saveState()
//
//            print("Moving \(card.rank) of \(card.suit) to foundation \(foundationIndex)")
//            reservePiles[reserveIndex].removeLast()
//            foundations[foundationIndex].append(card)
//
//            // If the foundation was empty, check if we need to reveal a new foundation
//            if foundations[foundationIndex].count == 1 {
//                revealNewFoundation(for: card)
//            }
//
//            score += 10
//            objectWillChange.send()
//        } else {
//            print("Cannot move \(card.rank) of \(card.suit) to foundation \(foundationIndex)")
//        }
//
//        checkForWin()
//    }
//
//
//
//    func drawFromStock() {
//        guard !stockPile.isEmpty else {
//            print("Recycling stock pile...")
//            stockPile.shuffle()
//            return
//
//        }
//
//        saveState()
//
//        let drawnCard = stockPile.removeLast()
//
//        for index in 0..<foundations.count {
//            if canMoveToFoundation(card: drawnCard, foundationIndex: index) {
//                foundations[index].append(drawnCard)
//                revealNewFoundation(for: drawnCard)
//                score += 10
//                objectWillChange.send()
//                return
//            }
//        }
//
//        stockPile.insert(drawnCard, at:0)
//
//        print("Cannot place drawn card \(drawnCard.rank) of \(drawnCard.suit) on any foundation.")
//    }
//
//
//    func revealNewFoundation(for card: Card) {
//        // Ensure valid foundation rank
//        guard let foundationRank = foundationRank else {
//            print("Foundation rank is not set.")
//            return
//        }
//
//        // Check if the card matches the foundation rank and is not in an existing suit
//        let existingSuits = foundations.compactMap { $0.first?.suit }
//        if card.rank == foundationRank && !existingSuits.contains(card.suit) {
//            // Find the next unrevealed foundation
//            if let emptyFoundationIndex = foundationRevealed.firstIndex(of: false) {
//                foundationRevealed[emptyFoundationIndex] = true
//                foundations[emptyFoundationIndex].append(card)
//                print("Revealed a new foundation pile for suit \(card.suit)")
//            } else {
//                print("No more foundations can be revealed.")
//            }
//        }
//    }
//
//    func canMoveToFoundation(card: Card, foundationIndex: Int) -> Bool {
//        guard foundationIndex < foundations.count else {
//            return false
//        }
//
//        // Check if the foundation is empty
//        if foundations[foundationIndex].isEmpty {
//            // A new foundation can only be started if the card matches the foundation rank
//            return card.rank == foundationRank
//        }
//
//        // Allow adding to an existing foundation if the suits match
//        let topCard = foundations[foundationIndex].last!
//        return card.suit == topCard.suit
//    }
//
//    struct FoundationAreaView: View {
//        var foundations: [[Card]]
//        var onEmptyPileTap: (Int) -> Void
//
//        var body: some View {
//            HStack(spacing: 10) {
//                ForEach(0..<4, id: \.self) { index in
//                    if foundations[index].isEmpty {
//                        EmptyPileView {
//                            onEmptyPileTap(index)
//                        }
//                    } else {
//                        FoundationView(cards: foundations[index])
//                    }
//                }
//            }
//        }
//    }
//
//}
//

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
    @Published var noMovesLeft: Bool = false                                // Track if moves left available
    @Published var currentAlert: GameAlert = .none
    private var undoStack: [GameState] = []                                 // Stack for undo states

    // Key for saving and loading game state
    private let saveKey = "SavedGame"
    
    enum GameAlert {
        case none
        case win
        case noMovesLeft
    }

    init() {
        if UserDefaults.standard.data(forKey: saveKey) != nil{
            loadGame()
        } else {
            startNewGame() // Load the saved game state when initializing
        }
    }

    // Represents the full game state
    private struct GameState: Codable {
        var deck: [Card]
        var reservePiles: [[Card]]
        var foundations: [[Card]]
        var stockPile: [Card]
        var foundationRevealed: [Bool]
        var score: Int
        var foundationRank: Card.Rank?
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

    func saveGame() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(GameState(
                deck: deck,
                reservePiles: reservePiles,
                foundations: foundations,
                stockPile: stockPile,
                foundationRevealed: foundationRevealed,
                score: score,
                foundationRank: foundationRank
            ))
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Failed to save game: \(error)")
        }
    }

    func loadGame() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            print("No saved game found.")
            startNewGame() // Start a new game if no saved game exists
            return
        }
        do {
            let decoder = JSONDecoder()
            let savedState = try decoder.decode(GameState.self, from: data)
            self.deck = savedState.deck
            self.reservePiles = savedState.reservePiles
            self.foundations = savedState.foundations
            self.stockPile = savedState.stockPile
            self.foundationRevealed = savedState.foundationRevealed
            self.score = savedState.score
            self.foundationRank = savedState.foundationRank
            print("Game loaded.")
        } catch {
            print("Failed to load game: \(error)")
            startNewGame() // Start a new game if loading fails
        }
    }

    func clearSavedGame() {
        UserDefaults.standard.removeObject(forKey: saveKey)
        print("Saved game cleared.")
    }
    
    func checkForWin() {
        let totalCardsInFoundations = foundations.reduce(0) { $0 + $1.count }
        print("Total cards in foundations: \(totalCardsInFoundations)") // Debug output
        
        if totalCardsInFoundations == 52 {
            currentAlert = .win
            print("Game Won")
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
        print("Reserve Piles:")
        for(index, pile) in reservePiles.enumerated(){
            print("Pile \(index): \(pile.map { $0.imageName})")
        }

        // Set up the first foundation
        if let firstCard = deck.popLast() {
            foundations[0].append(firstCard)
            foundationRank = firstCard.rank
            print("First Foundation Card: \(firstCard.imageName)")
        }

        // Remaining cards go to the stock
        stockPile = deck
        print("Stock Pile Count: \(stockPile.count)")
        score = 0
        gameWon = false
        saveGame() // Save the initial state of the new game
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
        guard foundationIndex < foundations.count else { return false }

         // Check if the foundation is empty
         if foundations[foundationIndex].isEmpty {
             // Only allow the card if it matches the foundation rank
             return card.rank == foundationRank
         }

         // Get the top card of the current foundation
         let topCard = foundations[foundationIndex].last!

         // For the first foundation: Allow cards of the same suit regardless of order
         if foundationIndex == 0 {
             return card.suit == topCard.suit
         }

         // For other foundations: Check if the card's rank has been played in the foundation above
         let aboveFoundationIndex = foundationIndex - 1
         let playedRanks = foundations[aboveFoundationIndex].map { $0.rank }

         // Allow the move if the suit matches and the rank has been played in the foundation above
         return card.suit == topCard.suit && playedRanks.contains(card.rank)


    }

    func moveCard(fromReserve reserveIndex: Int, toFoundation foundationIndex: Int) {
        guard !reservePiles[reserveIndex].isEmpty else {
            print("Reserve pile \(reserveIndex) is empty.")
            return
        }

        let card = reservePiles[reserveIndex].last!

        if canMoveToFoundation(card: card, foundationIndex: foundationIndex) {
            saveState()

            reservePiles[reserveIndex].removeLast()
            foundations[foundationIndex].append(card)

            score += 10
            checkForWin()

            if currentAlert != .win { _ = checkForAvailableMoves() }
            objectWillChange.send()
            saveGame()
        } else {
            print("Cannot move \(card.rank) of \(card.suit) to foundation \(foundationIndex)")
        }
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
    
    func drawFromStock() {
        guard !stockPile.isEmpty else {
            print("Recycling stock pile...")
            stockPile.shuffle()
            saveGame() // Save the updated state
            return
        }

        saveState()

        let drawnCard = stockPile.removeLast()
        for index in 0..<foundations.count {
            if canMoveToFoundation(card: drawnCard, foundationIndex: index) {
                foundations[index].append(drawnCard)
                revealNewFoundation(for: drawnCard)
                score += 10
                
                checkForWin()
                if gameWon { return }
                objectWillChange.send()
                saveGame() // Save the updated state
                if !checkForAvailableMoves(){
                    noMovesLeft = true
                }
                return
            }
        }

        stockPile.insert(drawnCard, at: 0)
    }
    
    func checkForAvailableMoves() -> Bool {
        // Check all reserve piles for possible moves
        for (reserveIndex, reservePile) in reservePiles.enumerated() {
            if let card = reservePile.last {
                for foundationIndex in 0..<foundations.count {
                    if canMoveToFoundation(card: card, foundationIndex: foundationIndex) {
                        return true
                    }
                }
            }
        }

        // Check the stock pile for possible moves
        for card in stockPile {
            for foundationIndex in 0..<foundations.count {
                if canMoveToFoundation(card: card, foundationIndex: foundationIndex) {
                    return true
                }
            }
        }

        // If no moves exist and the game is not won
        if currentAlert != .win {
            currentAlert = .noMovesLeft
        }
        return false
    }

    private func saveState() {
        undoStack.append(GameState(
            deck: deck,
            reservePiles: reservePiles,
            foundations: foundations,
            stockPile: stockPile,
            foundationRevealed: foundationRevealed,
            score: score,
            foundationRank: foundationRank
        ))
    }
    
    
}
