import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var contentViewModel = ContentViewModel()
    var body: some View {
        VStack {
            switch contentViewModel.tabHandler {
            case .home:
//                HomeView()
                TestUIView()
            case .myProfile:
//                QuickStartButtonView()
                TestUIView()
            case .quickStart:
//                MyProfileView()
                TestUIView()

            }
            CustomTabView(contentViewModel: contentViewModel)
        }
    }
}
    
    #Preview {
        ContentView()
    }
