import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var contentViewModel = ContentViewModel()
    var body: some View {
        ZStack {
            VStack {
                switch contentViewModel.tabHandler {
                case .home:
                    //                HomeView()
                    TestUIView()
                    
                case .myProfile:
                    //                MyProfileView()
                    TestUIView()
                    
                }
            }
            VStack {
                if contentViewModel.isShowingNewPost {
                    QuickStartButtonView(contentViewModel: contentViewModel)
                }
                Spacer()
                CustomTabView(contentViewModel: contentViewModel)
            }
        }
    }
}
    
    #Preview {
        ContentView()
    }
