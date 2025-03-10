import SwiftUI

struct HomeView: View {
    @State var posts: [PostViewModel]
    
    // 한 줄에 하나의 아이템만 표시되도록 그리드 설정
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(posts, id: \.postId) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            VStack(spacing: 0) {
                                PostView(post: post)
                                
                                Divider()
                                    .padding(.horizontal, 8)
                            }
                            .contentShape(Rectangle()) // 전체 영역을 탭 가능하게 만듦
                        }
                        .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
                    }
                }
            }
            .navigationTitle("홈")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    var posts: [PostViewModel] = [
        PostViewModel.createPreview(uploaderName: "사용자1"),
        PostViewModel.createPreview(uploaderName: "사용자2"),
        PostViewModel.createPreview(uploaderName: "사용자3"),
        PostViewModel.createPreview(uploaderName: "사용자4"),
        PostViewModel.createPreview(uploaderName: "사용자6"),
        PostViewModel.createPreview(uploaderName: "사용자7"),
        PostViewModel.createPreview(uploaderName: "사용자8")
    ]
    HomeView(posts: posts)
        .accentColor(.primary)
}
