import SwiftUI

// MARK: - EmptyPileView
struct EmptyPileView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5]))
            .frame(width: 80, height: 120)
    }
}
