import SwiftUI

enum GameNavigationDestination: Hashable{
    case menu
}
struct TestView: View {
        // State variable to keep track of the elapsed time
        @State private var elapsedTime: Int = 0
        @Environment(\.presentationMode) var presentationMode
    @State private var naviPath = NavigationPath()
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background color
                Color(red: 0.1, green: 0.4, blue: 0.35).edgesIgnoringSafeArea(.all)
                
                // Top row with counters
                NavigationStack(path: $naviPath){
                    VStack {
                        HStack {
                            // Score Counter
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.3529, green: 0.6980, blue: 0.6314))
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                                .overlay(Text("0"))
                            
                            Spacer()
                            
                            // Timer Counter
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.3529, green: 0.6980, blue: 0.6314))
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05)
                                .overlay(
                                    Text(timerString(from: elapsedTime))
                                        .font(.custom("TAN - MON CHERI", size: 16))
                                        .foregroundColor(.black)
                                )
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        Spacer()
                        
                        // Bottom row with menu, hint, and undo buttons
                        HStack {
                            // Menu Button
                            NavigationLink(destination: ContentView()){
                                Text("menu")
                                    .font(.custom("TAN - MON CHERI", size: 17))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.25)
                                    .background(Color(hex: "#5ab2a1"))
                                    .cornerRadius(20)
                            }
                            
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
                            }
                            
                            Spacer()
                            
                            // Undo Button
                            Button(action: {}) {
                                Image(systemName: "arrow.uturn.backward")
                                    .foregroundColor(.yellow)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .background(Color(hex: "#5ab2a1"))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                }
                // Timer updates every second
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        elapsedTime += 1
                    }
                }
                .navigationDestination(for: GameNavigationDestination.self){ destination in
                    switch destination{
                    case .menu:
                        ContentView()
                    }
                }
                
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
        
        // Helper function to format the elapsed time as a string
        private func timerString(from seconds: Int) -> String {
            let minutes = seconds / 60
            let seconds = seconds % 60
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
    
