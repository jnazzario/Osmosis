import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background coloe
            Color(hex: "#285C4D")
                .ignoresSafeArea()
            // Title
            VStack {
                Text("Osmosis")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
            // Card symbols
                HStack{
                    Image(systemName: "club.fill")
                    Image(systemName: "spades.fill")
                    Image(systemName: "diamond.fill")
                    Image(systemName: "heart.fill")
                }
                .foregroundColor(.red)
                .padding(.bottom)
                
                VStack{
                    Spacer()
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 20)
                    Spacer()
                }
                
            }
        }
    }
}

// Extension to convert hex color to SwiftUI Color
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct OsmosisHomePage: View {
    var body: some View {
        ZStack {
            // Background
            Color.teal.ignoresSafeArea()

            // Title
            Text("Osmosis")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding()

            // Card symbols
            HStack {
                Image(systemName: "clubs.fill")
                Image(systemName: "spades.fill")
                Image(systemName: "diamond.fill")
                Image(systemName: "heart.fill")
            }
            .foregroundColor(.white)
            .padding(.bottom)

            // Vertical lines
            VStack {
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 20)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.black)

            // Second vertical line
            // ... (similar to the first line, but with different colors and placement)
        }
    }
}
