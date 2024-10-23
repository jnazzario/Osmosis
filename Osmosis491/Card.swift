import Foundation

// MARK: - Card Model
struct Card: Identifiable {
    let id = UUID()
    let suit: Suit
    let rank: Rank

    enum Suit: String, CaseIterable {
        case hearts, diamonds, clubs, spades
    }

    enum Rank: String, CaseIterable {
        case ace = "A", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", ten = "10", jack = "J", queen = "Q", king = "K"
    }

    // Computed property to generate the image name for each card
    var imageName: String {
        return "\(rank.rawValue)_of_\(suit.rawValue)"
    }
}
