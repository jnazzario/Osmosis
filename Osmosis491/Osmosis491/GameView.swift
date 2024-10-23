import SwiftUI

struct GameView: View {
        // State variable to keep track of the elapsed time
        @State private var elapsedTime: Int = 0
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background color
                Color(red: 0.1, green: 0.4, blue: 0.35).edgesIgnoringSafeArea(.all)
                    VStack {
                        // Top row (Score & Timer)
                        HStack {
                            // Score Counter (Box will eventually show score)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.3529, green: 0.6980, blue: 0.6314))
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                            
                            Spacer()
                            
                            // Timer
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.3529, green: 0.6980, blue: 0.6314))
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                                .overlay(
                                    Text(timerString(from: elapsedTime))
                                        .font(.custom("TAN - MON CHERI", size: 16))
                                        .foregroundColor(.black)
                                ) // Overlay line 27
                        } // HStack line 15
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        Spacer()
                        
                        // Bottom row (menu, hint, and undo buttons)
                        HStack {
                            // Menu
                            NavigationLink(destination: ContentView()) {
                                Text("menu")
                                    .font(.custom("TAN - MON CHERI", size: 17))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.25)
                                    .background(Color(hex: "#5ab2a1"))
                                    .cornerRadius(20)
                            } // Button line 41
                            
                            Spacer()
                            
                            // Hint Button
                            Button(action: {}) {
                                Text("hint")
                                    .font(.custom("TAN - MON CHERI", size: 17))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.25)
                                    .background(Color(hex: "#5ab2a1"))
                                    .cornerRadius(20)
                            } // Button line 54
                            
                            Spacer()
                            
                            // Undo Button
                            Button(action: {}) {
                                Image(systemName: "arrow.uturn.backward")
                                    .foregroundColor(.yellow)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .background(Color(hex: "#5ab2a1"))
                                    .clipShape(Circle())
                            } // Button line 67
                        } // HStack line 39
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    } //VStack line 14
                } //ZStack line 11
            
                // Timer updates every second
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        elapsedTime += 1
                    }
                } // onAppear line 80
            }
        }
    }
        
        // Helper function to format time
        private func timerString(from seconds: Int) -> String {
            let minutes = seconds / 60
            let seconds = seconds % 60
            return String(format: "%d:%02d", minutes, seconds)
        }

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
    
