import Foundation
import SwiftUI

struct FoundationView: View {
    var cards: [Card]

    var body: some View {
        ZStack {
            if cards.isEmpty {
                // Display an empty placeholder if there are no cards in the foundation pile
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 80, height: 152)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5]))
                    )
            } else {
                // Display the cards in the foundation pile
                ZStack(alignment: .leading) {
                    ForEach(cards.indices, id: \.self) { index in
                        CardView(card: cards[index])
                            .offset(x: CGFloat(index) * 15)
                    }
                }
                .frame(width: 160, height: 120)
            }
        }
    }
}

