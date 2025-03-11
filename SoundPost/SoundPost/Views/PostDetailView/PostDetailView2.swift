import SwiftUI

struct PostDetailView2: View {
    @ObservedObject var post: PostViewModel
    @State private var comments: [CommentViewModel] = []
    
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
                // 녹음 시작
                // 녹음 완료
                // 코멘츠 객체 생성
                // 코멘츠 객체 서버 등록
                // 해당
                
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

//#Preview {
//    PostDetailView(post: PostViewModel.createPreview())
//}
