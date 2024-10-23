import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ZStack{
            Color(hex: "#fffbed")
                .ignoresSafeArea()
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("   How to Play Osmosis")
                    .font(.custom("TAN - MON CHERI", size: 26))
                    .multilineTextAlignment(.center)
                    .padding()

                Text("""
                    1. Cards must be moved in order by rank, starting witha foundation card dealt at the beginning of the game
                    
                    2. Only cards of the same suit and in ascending rank order can be moved to the foundation.
                    
                    3. Use the reserve piles to find and organize cards.
                    
                    The objective is to build all four foundation piles from Ace to King.
                    """)
                    .font(.custom("TAN - MON CHERI", size: 17))
                    
                    .padding()
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            HStack(spacing: 20){
                NavigationLink(destination: ContentView()){
                    Text("Home")
                        .font(.custom("TAN - MON CHERI", size: 23))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(hex:"#F93822"))
                        .cornerRadius(10)
                }
                NavigationLink(destination: GameView()){
                    Text("Play new deal")
                        .font(.custom("TAN - MON CHERI", size: 23))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(hex:"#D6001C"))
                        .cornerRadius(10)
                }
                }
            .padding(.bottom, 40)
            }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
