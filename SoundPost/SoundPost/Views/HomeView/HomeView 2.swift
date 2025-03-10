import SwiftUI

struct HomeView2: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var posts: [PostViewModel] = []
    
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
                                    .padding(.leading)
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
