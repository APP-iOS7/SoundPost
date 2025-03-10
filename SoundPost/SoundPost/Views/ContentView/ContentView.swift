import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var contentViewModel = ContentViewModel()
    var body: some View {
            VStack {
                ZStack{
                    switch contentViewModel.tabHandler {
                    case .home:
                        HomeView()
//                        TestUIView()
                        
                    case .myProfile:
                        //MyProfileView()
                        TestUIView2()
                    }
                        if contentViewModel.isShowingNewPost {
                            QuickStartButtonView(contentViewModel: contentViewModel)
                                .transition(AnyTransition.move(edge: .bottom).combined(with: AnyTransition.opacity))
                        }
                }
                CustomTabView(contentViewModel: contentViewModel)
            }
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeInOut, value: contentViewModel.isShowingNewPost)
        }
}
    
    #Preview {
        ContentView()
    }
