import SwiftUI
//
//struct ContentView: View {
//    @State private var naviPath = NavigationPath()
//    var body: some View {
//        NavigationStack(path: $naviPath) {
//            ZStack {
//                // Background color
//                Color(hex: "#3c7f72")
//                    .ignoresSafeArea()
//                Image("Background")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                    .opacity(1.0)
//
//                VStack {
//                    Spacer()
//
//                    // App title
//                    Text("Osmosis")
//                        .font(.custom("TAN - MON CHERI", size: 50))
//                        .foregroundColor(.black)
//                        .padding(.top, 39)
//
//                    // Card Suit Symbols below the title
//                    HStack(spacing: 0.25) {
//                        Image(systemName: "suit.club.fill")
//                        Image(systemName: "suit.spade.fill")
//                        Image(systemName: "suit.diamond.fill")
//                            .foregroundColor(Color(hex: "#D6001C"))
//                        Image(systemName: "suit.heart.fill")
//                            .foregroundColor(Color(hex: "#D6001C"))
//                    } // HStack end
//                    .font(.system(size: 45))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 9)
//
//
//                    NavigationLink(destination: GameView()) {
//                        Text("new deal")
//                            .font(.custom("TAN - MON CHERI", size: 30))
//                            .foregroundColor(Color(.black))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 125)
//                    } // NavLink End line 33
//                    .navigationBarHidden(true)// Hide navigation bar on the main view
//                    .navigationBarBackButtonHidden(true)
//
//                    NavigationLink(destination: InstructionsView()){
//                        Text("how to")
//                            .font(.custom("TAN - MON CHERI", size: 30))
//                            .foregroundColor(Color(.black))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 146)
//                    }
//                    Spacer()
//                } // VStack end
//                .padding()
//            } // ZStack end lin 6
//           .navigationBarHidden(true)// Hide navigation bar on the main view
//           .navigationBarBackButtonHidden(true)
//        } // NavigationView
//    }
//}
//
//// Extension to use hex colors in SwiftUI
////extension Color {
////    init?(hex: String) {
////        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
////        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
////
////        var rgb: UInt64 = 0
////        Scanner(string: hexSanitized).scanHexInt64(&rgb)
////
////        let red = Double((rgb >> 16) & 0xFF) / 255.0
////        let green = Double((rgb >> 8) & 0xFF) / 255.0
////        let blue = Double(rgb & 0xFF) / 255.0
////
////        self.init(red: red, green: green, blue: blue)
////    }
////}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
struct ContentView: View {
    @State private var naviPath = NavigationPath()
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
                        .padding(.top, 39)

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
                    NavigationLink(destination: GameView()) {
                        Text("new deal")
                            .font(.custom("TAN - MON CHERI", size: 30))
                            .foregroundColor(Color(.black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 125)
                    } // NavLink End line 33
                    
                    .navigationBarHidden(true)// Hide navigation bar on the main view
                    .navigationBarBackButtonHidden(true)

                    // Link to InstructionsView
                    NavigationLink(destination: InstructionsView()){
                        Text("how to")
                            .font(.custom("TAN - MON CHERI", size: 30))
                            .foregroundColor(Color(.black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 146)
                    }
                    Spacer()
                } // VStack end
                .padding()
            } // ZStack end lin 6
           .navigationBarHidden(true)// Hide navigation bar on the main view
           .navigationBarBackButtonHidden(true)
        } // NavigationStack end
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
