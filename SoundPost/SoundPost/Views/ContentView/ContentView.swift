import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var contentViewModel = ContentViewModel()
    var body: some View {
        VStack {
            switch contentViewModel.tabHandler {
            case .home:
                HomeView()
            case .myProfile:
                QuickStartButtonView()
            case .quickStart:
                MyProfileView()
            }
            CustomTabView(selectedTab: $contentViewModel.tabHandler)
        }
    }
}
    
    #Preview {
        ContentView()
    }
