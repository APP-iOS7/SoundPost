import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var contentViewModel = ContentViewModel()
    
    var posts: [PostViewModel] = [
    ]
    var body: some View {
        VStack(spacing: 0) {

                ZStack{
                    switch contentViewModel.tabHandler {
                    case .home:
                        HomeView2()
//                        TestUIView()
                        
                    case .myProfile:
                        //MyProfileView()
                        ProfileView()
                    }
                        if contentViewModel.isShowingNewPost {
                            QuickStartButtonView(contentViewModel: contentViewModel, quickStartViewModel: QuickStartButtonViewModel(authViewModel: authViewModel, uploader: authViewModel.user))
                                .transition(AnyTransition.move(edge: .bottom).combined(with: AnyTransition.opacity))
                        }
                }
                CustomTabView(contentViewModel: contentViewModel)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeInOut, value: contentViewModel.isShowingNewPost)
            .alert("포스팅 성공", isPresented: $authViewModel.postingFinished, actions: {
                Button("OK") {
                    authViewModel.postingFinished.toggle()
                        }
            }, message: {
                Text("포스팅을 성공하였습니다!")
            })
        }
}
    
    #Preview {
        ContentView()
    }
