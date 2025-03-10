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
            .padding(.vertical)
        }
    }
}

#Preview {
    PostDetailView(post: PostViewModel.createPreview())
}
