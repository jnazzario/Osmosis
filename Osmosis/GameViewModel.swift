import Foundation
import SwiftUI

// MARK: - Game ViewModel
class GameViewModel: ObservableObject {
    @Published var deck: [Card] = []
    @Published var reservePiles: [[Card]] = [[], [], [], []]
    @Published var foundations: [[Card]] = [[], [], [], []]

    init() {
        startNewGame()
    }

    func startNewGame() {
        // Create a new deck and shuffle it
        deck = createDeck().shuffled()

        // Distribute cards to reserve piles and foundations
        for index in 0..<4 {
            for _ in 0..<4 {
                if let card = deck.popLast() {
                    reservePiles[index].append(card)
                }
            }
        }

        for index in 0..<4 {
            if let card = deck.popLast() {
                foundations[index].append(card)
            }
        }
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

    func canMoveToFoundation(card: Card, foundationIndex: Int) -> Bool {
        guard let topCard = foundations[foundationIndex].last else {
            return false
        }
        return card.suit == topCard.suit && isNextRank(current: topCard.rank, next: card.rank)
    }

    private func isNextRank(current: Card.Rank, next: Card.Rank) -> Bool {
        let ranks = Card.Rank.allCases
        if let currentIndex = ranks.firstIndex(of: current),
           let nextIndex = ranks.firstIndex(of: next) {
            return nextIndex == currentIndex + 1
        }
        return false
    }

    func moveCard(fromReserve reserveIndex: Int, toFoundation foundationIndex: Int) {
        guard !reservePiles[reserveIndex].isEmpty else { return }

        let card = reservePiles[reserveIndex].last!

        if canMoveToFoundation(card: card, foundationIndex: foundationIndex) {
            reservePiles[reserveIndex].removeLast()
            foundations[foundationIndex].append(card)
        }
    }
}
