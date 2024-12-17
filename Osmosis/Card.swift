import Foundation

struct Card: Identifiable, Codable {
    let id: UUID
    let suit: Suit
    let rank: Rank

    enum Suit: String, CaseIterable, Codable {
        case hearts, diamonds, clubs, spades
    }

    enum Rank: String, CaseIterable, Codable, Comparable {
        case ace = "A", two = "2", three = "3", four = "4", five = "5", six = "6"
        case seven = "7", eight = "8", nine = "9", ten = "10"
        case jack = "J", queen = "Q", king = "K"

        // Define the order of ranks
        static let rankOrder: [Rank] = [.ace, .two, .three, .four, .five, .six,
                                        .seven, .eight, .nine, .ten, .jack, .queen, .king]

        static func < (lhs: Rank, rhs: Rank) -> Bool {
            return rankOrder.firstIndex(of: lhs)! < rankOrder.firstIndex(of: rhs)!
        }
    }


    init(id: UUID = UUID(), suit: Suit, rank: Rank) {
        self.id = id
        self.suit = suit
        self.rank = rank
    }

    // Computed property to generate the image name
    var imageName: String {
        "\(rank.rawValue)_of_\(suit.rawValue)"
    }
}

