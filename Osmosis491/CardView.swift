import SwiftUI

// MARK: - CardView
struct CardView: View {
    let card: Card

    var body: some View {
        Image(card.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 120)
            .cornerRadius(8)
            .shadow(radius: 5)
    }
}
