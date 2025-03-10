import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var contentViewModel = ContentViewModel()
    var posts: [PostViewModel] = [
        PostViewModel.createPreview(uploaderName: "사용자1"),
        PostViewModel.createPreview(uploaderName: "사용자2"),
        PostViewModel.createPreview(uploaderName: "사용자3"),
        PostViewModel.createPreview(uploaderName: "사용자4"),
        PostViewModel.createPreview(uploaderName: "사용자6"),
        PostViewModel.createPreview(uploaderName: "사용자7"),
        PostViewModel.createPreview(uploaderName: "사용자8")
    ]
    var body: some View {
        VStack(spacing: 0) {
                ZStack{
                    switch contentViewModel.tabHandler {
                    case .home:
                        HomeView(posts: posts)
//                        TestUIView()
                        
                    case .myProfile:
                        //MyProfileView()
                        ProfileView()
                    }
                        if contentViewModel.isShowingNewPost {
                            QuickStartButtonView(contentViewModel: contentViewModel, quickStartViewModel: QuickStartButtonViewModel(uploader: authViewModel.user))
                                .transition(AnyTransition.move(edge: .bottom).combined(with: AnyTransition.opacity))
                        }
                }
                CustomTabView(contentViewModel: contentViewModel)
            }
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeInOut, value: contentViewModel.isShowingNewPost)
//            .onChange(of: authViewModel.user?.posts.count) {
//                print("변했어!")
//                print(authViewModel.user?.posts)
//            }
        }
}
    
    #Preview {
        ContentView()
    }
