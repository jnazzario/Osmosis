import SwiftUI
struct ContentView: View {
    @State private var naviPath = NavigationPath()
    @State private var hasSavedGame: Bool = UserDefaults.standard.data(forKey: "SavedGame") != nil
    var body: some View {
        NavigationStack(path: $naviPath) {
            ZStack {
                // Background color
                Color(hex: "#3c7f72")
                    .ignoresSafeArea()
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(1.0)

                VStack {
                    Spacer()

                    // App title
                    Text("Osmosis")
                        .font(.custom("TAN - MON CHERI", size: 50))
                        .foregroundColor(.black)
                        .padding(.top, 25)

                    // Card Suit Symbols below the title
                    HStack(spacing: 0.25) {
                        Image(systemName: "suit.club.fill")
                        Image(systemName: "suit.spade.fill")
                        Image(systemName: "suit.diamond.fill")
                            .foregroundColor(Color(hex: "#D6001C"))
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(Color(hex: "#D6001C"))
                    } // HStack end
                    
                    .font(.system(size: 45))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 9)

                    // Link to GameView
                    NavigationLink(destination: GameView(viewModel: {
                        let newGameViewModel = GameViewModel()
                        newGameViewModel.startNewGame() // Explicitly start a new game
                        return newGameViewModel
                    }())) {
                        Text("new deal")
                            .font(.custom("TAN - MON CHERI", size: 26))
                            .foregroundColor(Color(.black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 125)
                    } // NavLink end line 33
                    
                    // Hide navigation bar on the main view
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    
                    if hasSavedGame{
                        NavigationLink(destination: GameView(viewModel: GameViewModel())){
                            Text("saved game")
                            .font(.custom("TAN - MON CHERI", size: 26))
                            .foregroundColor(Color(.black))
                            .frame(maxWidth: .infinity)
                        }
                    }

                    // Link to InstructionsView
                    NavigationLink(destination: InstructionsView()){
                        Text("how to")
                            .font(.custom("TAN - MON CHERI", size: 26))
                            .foregroundColor(Color(.black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 146)
                    } // NavLink end line 52
                    
                    Spacer()
                    
                } // VStack end
                
                .padding()
                
            } // ZStack end line 6
            
            // Hide navigation bar on the main view
           .navigationBarHidden(true)
           .navigationBarBackButtonHidden(true)
            
        } // NavigationStack end line 5
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
