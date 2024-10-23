import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Text("Menu Page")
                .font(.largeTitle)
                .padding()

            // Example buttons or menu options
            Button("Start Game") {
                // Start game action
            }
            .padding()

            Button("Instructions") {
                // Instructions action
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Menu")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
