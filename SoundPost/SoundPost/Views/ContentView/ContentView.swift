import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        TabView {
            Tab {
//                HomeView()
            } label: {
                Image(systemName: "house.fill")
                Text("홈")
            }
            Tab {
                
            } label: {
                Image(systemName: "plus.circle.fill")
                Text("시작")
            }
            Tab {
//                MyProfileView()
            } label: {
                Image(systemName: "person.fill")
                Text("내 프로필")
            }
        }
        .tint(.black)
    }
}
    
    #Preview {
        ContentView()
    }
