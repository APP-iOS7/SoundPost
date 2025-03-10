import SwiftUI

struct PostDetailView: View {
    @ObservedObject var post: PostViewModel
    @State private var comments: [CommentViewModel] = [
        CommentViewModel.createPreview(uploaderName: "사용자1"),
        CommentViewModel.createPreview(uploaderName: "사용자2"),
        CommentViewModel.createPreview(uploaderName: "사용자3"),
        CommentViewModel.createPreview(uploaderName: "사용자4"),
        CommentViewModel.createPreview(uploaderName: "사용자6"),
        CommentViewModel.createPreview(uploaderName: "사용자7"),
        CommentViewModel.createPreview(uploaderName: "사용자8")
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                PostView(post: post)
                
                Divider()
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text("대답")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(comments, id: \.commentId) { comment in
                        VStack(spacing: 0) {
                            CommentView(comment: comment)
                            
                            Divider()
                                .padding(.leading)
                        }
                    }
                }
                .padding(.top)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            // 하단에 고정된 대답하기 버튼
            Button {
                // TODO: 대답하기 버튼 액션
            } label: {
                Text("대답 하기")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(.primaryNeon)
            }
        }
    }
}

#Preview {
    PostDetailView(post: PostViewModel.createPreview())
}
