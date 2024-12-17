import SwiftUI
struct GameView: View {
    @StateObject var viewModel = GameViewModel()         // The view model that manages the game state
    @State private var elapsedTime: Int = 0              // Timer for the game
    @State private var gameTimer: Timer?                 // Timer instance
    @State private var selectedCardIndex: Int? = nil     // Track which card is selected from the reserve piles
    @State private var navigateToHome: Bool = false      // Helps bring user to home screen
    @State private var isPaused: Bool = false            // Tracks whether game is paused


    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background color
                Color(red: 0.1, green: 0.4, blue: 0.35).edgesIgnoringSafeArea(.all)

                VStack {
                    // Top row
                    HStack {
                        // Score box
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.3529, green: 0.6980, blue: 0.6314))
                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                            .overlay(
                                Text("\(viewModel.score)")
                                    .font(.custom("TAN - MON CHERI", size: 16))
                                    .foregroundColor(.black))
                            .padding(.leading, 20)

                        Spacer()
                        // Timer box
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.3529, green: 0.6980, blue: 0.6314))
                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                            .overlay(
                                Text(timerString(from: elapsedTime))
                                    .font(.custom("TAN - MON CHERI", size: 16))
                                    .foregroundColor(.black)
                            )
                            .padding(.trailing, 20)
                    }
                    .padding(.top, 10)

                    Spacer()

                    // Display Reserve Piles and Foundations
                    HStack(alignment: .top, spacing: -33) {
                        // Reserve Piles
                        ScrollView(.vertical) {
                            VStack(spacing: 5) {
                                ForEach(0..<viewModel.reservePiles.count, id: \.self) { index in
                                    VStack {
                                        if let topCard = viewModel.reservePiles[index].last {
                                            CardView(card: topCard)
                                                .onTapGesture {
                                                    print("Tapped on reserve pile \(index), card: \(topCard.rank) of \(topCard.suit)") // Debug print
                                                    selectedCardIndex = index
                                                }
                                                .border(selectedCardIndex == index ? Color.yellow : Color.clear, width: 2)
                                        } else {
                                            EmptyPileView {}

                                        }
                                    }
                                }
                            }
                            .padding(.top, 10)
                        }
                        .frame(width: geometry.size.width * 0.2)
                        .padding(.leading, 20)

                        // Foundation Piles
                        VStack(spacing: 5) {
                            ForEach(0..<viewModel.foundations.count, id: \.self) { foundationIndex in
                                if viewModel.foundations[foundationIndex].isEmpty {
                                    // Show Empty Pile View if the foundation pile is empty
                                    EmptyPileView {
                                        print("Tapped on empty pile at index \(foundationIndex)")
                                        if let reserveIndex = selectedCardIndex {
                                            // Attempt to move the selected card to the empty foundation pile
                                            viewModel.moveCard(fromReserve: reserveIndex, toFoundation: foundationIndex)
                                            selectedCardIndex = nil
                                        }
                                    }
                                    .frame(width: 100, height: 150)
                                } else {
                                    // Show Foundation Pile if it contains cards
                                    ZStack(alignment: .leading) {
                                        ForEach(viewModel.foundations[foundationIndex].indices, id: \.self) { cardIndex in
                                            CardView(card: viewModel.foundations[foundationIndex][cardIndex])
                                                .offset(x: CGFloat(cardIndex) * 15) // Card offset
                                        }
                                    }
                                    .frame(width: 160, height: 120)
                                    .onTapGesture {
                                        if let reserveIndex = selectedCardIndex {
                                            viewModel.moveCard(fromReserve: reserveIndex, toFoundation: foundationIndex)
                                            selectedCardIndex = nil
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 10)


                        Spacer()
                    } // HStack end

                    // Bottom row (menu, pause, undo, and stock pile)
                    HStack {
                        // Menu button on the bottom left
                        NavigationLink(destination: ContentView()) {

                            Text("menu")
                                .font(.custom("TAN - MON CHERI", size: 15))
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: geometry.size.width * 0.24)
                                .background(Color(hex: "#5ab2a1"))
                                .cornerRadius(20)
                        }
                        .padding(.leading, 10)
                        Spacer()

                        // Pause Button
                        Button(action: {
                            togglePause()
                        }) {
                            Text("pause")
                                .font(.custom("TAN - MON CHERI", size: 15))
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: geometry.size.width * 0.24)
                                .background(Color(hex: "#5ab2a1"))
                                .cornerRadius(20)
                        }

                        Spacer()

                        // Undo Button
                        Button(action: {
                            viewModel.undoLastMove()
                        }) {
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor(.yellow)
                                .padding()
                                .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                .background(Color(hex: "#5ab2a1"))
                                .clipShape(Circle())
                        }

                        .padding(.trailing, 10)
                        Spacer()

                        // Stock Pile in the bottom right corner
                        VStack {
                            if let topCard = viewModel.stockPile.last {
                                CardView(card: topCard)
                                    .onTapGesture {
                                        // Handle tapping the stock pile (e.g., drawing a card)
                                        viewModel.drawFromStock()
                                    }
                            } else {
                                EmptyPileView {}
                            }
                        }
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.2)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    .padding(.bottom, 20)
                } // VStack end
                
                if isPaused{
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            togglePause()
                        }
                    VStack(spacing: 20){
                        Text("Game Paused")
                            .font(.custom("TAN - MON CHERI", size: 40))
                            .foregroundColor(Color(hex: "fffbed"))
                        Text("Tap Screen to Continue")
                            .font(.custom("TAN - MON CHERI", size: 28))
                            .foregroundColor(Color(hex: "fffbed"))
                    }
                }
            } // ZStack end
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.currentAlert != .none},
                set: { if !$0 {viewModel.currentAlert = .none}})) {
                    switch viewModel.currentAlert {
                    case .win:
                        stopTimer()
                        let formattedTime = timerString(from: elapsedTime)
                        return Alert(
                            title: Text("Congratulations!"),
                            message: Text("You have won the game!\nTime: \(formattedTime)\nScore: \(viewModel.score)"),
                            primaryButton: .default(Text("New Deal?")) {
                                startNewDeal() // Restart the game
                            },
                            secondaryButton: .cancel(Text("Return Home")){
                                navigateToHome = true
                            }
                        )
                    case .noMovesLeft:
                        return Alert(
                            title: Text("No Moves Left"),
                            message: Text("Would you like to start a new game?"),
                            primaryButton: .default(Text("New Game")){
                                startNewDeal()
                            },
                            secondaryButton: .cancel(Text("Return Home")){
                                navigateToHome = true
                            }
                        )
                    default:
                        return Alert(title: Text("")) // Fallback empty alert
                    }
            }
            
            .navigationDestination(isPresented: $navigateToHome){
                ContentView()
            }
        } // GeometryReader end
        .onAppear {
             startTimer() // Start the timer when the view appears
         }
         .onDisappear {
             stopTimer() // Stop the timer when the view disappears
         }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    // Helper function to format time
    private func timerString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    // Helper function to start the timer
    private func startTimer() {
        stopTimer() // Ensure any existing timer is invalidated
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedTime += 1
        }
    }

    // Helper function to stop the timer
    private func stopTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }

    // Start a new game and reset the timer
    private func startNewDeal() {
        viewModel.startNewGame()
        elapsedTime = 0 // Reset the timer
        startTimer() // Restart the timer
    }
    
    // Helper function for pause
    private func togglePause() {
        isPaused.toggle()
        if isPaused {
            stopTimer()
        } else{
            startTimer()
        }
    }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
