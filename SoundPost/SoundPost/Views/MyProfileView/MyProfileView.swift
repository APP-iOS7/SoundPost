import SwiftUI

struct MyProfileView: View {
    @State var posts: [PostViewModel] = [
        PostViewModel.createPreview(uploaderName: "사용자1"),
        PostViewModel.createPreview(uploaderName: "사용자2"),
        PostViewModel.createPreview(uploaderName: "사용자3"),
        PostViewModel.createPreview(uploaderName: "사용자4"),
        PostViewModel.createPreview(uploaderName: "사용자6"),
        PostViewModel.createPreview(uploaderName: "사용자7"),
        PostViewModel.createPreview(uploaderName: "사용자8")
    ]
    
    // 한 줄에 하나의 아이템만 표시되도록 그리드 설정
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    UserProfileView()
                    
                    Divider()
                        .padding(.leading)
                    
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
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UserProfileView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()

            VStack(alignment: .leading) {
                Text("Name")
                Text("SignIn Date")
            }
            .padding(.bottom)
            
            Spacer()
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
    MyProfileView(posts: posts)
        .accentColor(.primary)
}

