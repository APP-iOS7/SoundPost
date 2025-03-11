import SwiftUI

struct HomeView2: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var posts: [PostViewModel] = []
    
    // 한 줄에 하나의 아이템만 표시되도록 그리드 설정
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(posts.sorted(by: { $0.uploadDate > $1.uploadDate }), id: \.postId) { post in
                        NavigationLink(destination: PostDetailView2(postViewModel: post, quickStartViewModel: QuickStartButtonViewModel(authViewModel: authViewModel, uploader: authViewModel.user))) {
                            VStack(spacing: 0) {
                                PostView(post: post)
                                Divider().padding(.leading)
                            }
                            .contentShape(Rectangle()) // 전체 영역을 탭 가능하게 만듦
                        }
                        .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
                    }
                }
            }
            .navigationTitle("홈")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                fetchAllPosts()
            }
        }
    }
    
    // 🔹 Firestore에서 모든 포스트 가져오기
    private func fetchAllPosts() {
        FirebaseManager.shared.getAllPosts { fetchedPosts in
            DispatchQueue.main.async {
                self.posts = fetchedPosts.map { PostViewModel.createPVMwithPost(post: $0, myId: authViewModel.user?.id ?? "") }
            }
        }
    }
}
