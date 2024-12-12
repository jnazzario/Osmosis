import Foundation
import SwiftUI
struct CardBackView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.blue)
            .frame(width: 80, height: 120)
            .shadow(radius: 5)
    }
}
