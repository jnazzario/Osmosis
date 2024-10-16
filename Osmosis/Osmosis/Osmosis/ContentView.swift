import SwiftUI

// Card Model
struct Card: Identifiable {
    let id = UUID()
    let rank: String
    let suit: String
}

// Sample Data for demo purposes (replace with actual game logic)
import SwiftUI


// Sample Data for demo purposes (replace with actual game logic)
let sampleTableau = [
    [Card(suit: "♠", rank: "6"), Card(suit: "♥", rank: "10")],
    [Card(suit: "♦", rank: "4")],
    [Card(suit: "♣", rank: "K")],
    [Card(suit: "♥", rank: "8")]
]
let sampleStockCard = Card(suit: "♠", rank: "3")

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background color
            Color(hex: "#285C4D")
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Top bar with score and timer
                HStack {
                    Text("0")
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                    Text("0:00")
                        .font(.title)
                        .padding(.trailing)
                }
                .padding(.top)

                // Tableau layout (stacked cards in columns)
                HStack(alignment: .top, spacing: 20) {
                    ForEach(sampleTableau, id: \.self) { column in
                        VStack {
                            ForEach(column) { card in
                                CardView(card: card)
                                    .padding(.bottom, 5)
                            }
                        }
                    }
                }
                .padding(.vertical)

                Spacer()

                // Stockpile and other interactive elements
                HStack {
                    Spacer()
                    CardView(card: sampleStockCard)
                    Rectangle()
                        .frame(width: 60, height: 90)
                        .foregroundColor(.clear)
                        .border(Color.black)
                    Spacer()
                }

                Spacer()

                // Bottom bar with buttons
                HStack {
                    Button("menu") {
                        // Menu action
                    }
                    .buttonStyle(RoundedButtonStyle())

                    Spacer()

                    Button("hint") {
                        // Hint action
                    }
                    .buttonStyle(RoundedButtonStyle())

                    Spacer()

                    Button(action: {
                        // Undo action
                    }) {
                        Image(systemName: "arrow.uturn.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .buttonStyle(RoundedButtonStyle())
                }
                .padding(.bottom, 20)
            }
        }
    }
}

// Card View for individual cards
struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 60, height: 90)
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 2)
                .border(Color.black)
            Text("\(card.rank)\(card.suit)")
           

let sampleStockCard = Card(rank: "3", suit: "♠")

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background color
            Color(hex: "#285C4D")
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Top bar with score and timer
                HStack {
                    Text("0")
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                    Text("0:00")
                        .font(.title)
                        .padding(.trailing)
                }
                .padding(.top)

                // Tableau layout (stacked cards in columns)
                HStack(alignment: .top, spacing: 20) {
                    ForEach(sampleTableau, id: \.self) { column in
                        VStack {
                            ForEach(column) { card in
                                CardView(card: card)
                                    .padding(.bottom, 5)
                            }
                        }
                    }
                }
                .padding(.vertical)

                Spacer()

                // Stockpile and other interactive elements
                HStack {
                    Spacer()
                    CardView(card: sampleStockCard)
                    Rectangle()
                        .frame(width: 60, height: 90)
                        .foregroundColor(.clear)
                        .border(Color.black)
                    Spacer()
                }

                Spacer()

                // Bottom bar with buttons
                HStack {
                    Button("menu") {
                        // Menu action
                    }
                    .buttonStyle(RoundedButtonStyle())

                    Spacer()

                    Button("hint") {
                        // Hint action
                    }
                    .buttonStyle(RoundedButtonStyle())

                    Spacer()

                    Button(action: {
                        // Undo action
                    }) {
                        Image(systemName: "arrow.uturn.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .buttonStyle(RoundedButtonStyle())
                }
                .padding(.bottom, 20)
            }
        }
    }
}

// Card View for individual cards
struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 60, height: 90)
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 2)
                .border(Color.black)
            Text("\(card.rank)\(card.suit)")
                .font(.largeTitle)
                .foregroundColor(card.suit == "♥" || card.suit == "♦" ? Color(hex: "#D6001C") : Color.black)
        }
    }
}

// Button style for the menu, hint, and undo buttons
struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(hex: "#86A397"))
            .foregroundColor(.black)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

