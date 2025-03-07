import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.primaryNeon)
            Text("Hello, world!")
            
            Text("Firebase 테스트")
                .font(.title)
                .padding()
            
            Button("Firebase 초기화 확인") {
                print("Firebase is configured: \(FirebaseApp.app() != nil)")
            }
            
            .padding()
        }
    }
}
    
    #Preview {
        ContentView()
    }
