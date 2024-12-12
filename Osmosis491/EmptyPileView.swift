import SwiftUI
struct EmptyPileView: View {
    var onTap: () -> Void // Callback for when the pile is tapped

    var body: some View {
        Rectangle()
            .fill(Color.clear) // Transparent fill so entire area clickable
            .frame(width: 80, height: 120)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5]))
            )
            .contentShape(Rectangle()) // Makes the entire rectangular area tappable
            .onTapGesture {
                onTap() // Trigger the action when tapped
            }
    }
}

