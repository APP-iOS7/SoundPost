import SwiftUI

struct PostDetailView2: View {
    @ObservedObject var post: PostViewModel
    @StateObject private var quickStartViewModel : QuickStartButtonViewModel
    @State private var comments: [CommentViewModel] = []
    @State var isShowingSheet: Bool = false
    init(post: PostViewModel, quickStartViewModel : QuickStartButtonViewModel) {
        self.post = post
        self._quickStartViewModel = StateObject(wrappedValue: quickStartViewModel)
    }
    
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
        .sheet(isPresented: $isShowingSheet) {
                    ModalContentView()
                .presentationDetents([.height(UIScreen.main.bounds.height / 7)])
                }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            // 하단에 고정된 대답하기 버튼
            Button {
                isShowingSheet.toggle()
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

struct ModalContentView: View {
    @ObservedObject private var commentButtonViewModel: ContentViewModel = ContentViewModel()
    var body: some View {
        VStack {
            Button {
                commentButtonViewModel.QuickStartSet()
            } label: {
                VStack {
                    switch commentButtonViewModel.QuickStartButtonClick {
                    case 1:
                        Image(systemName: "record.circle")
                            .foregroundColor(.red)
                            .font(.title)
                        Text("녹음")
                            .foregroundColor(.red)
                            .font(.caption)
                    case 2 :
                        Image(systemName: "stop.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                        Text("녹음중")
                            .foregroundColor(.red)
                            .font(.caption)
                    case 3 :
                        Image(systemName: "record.circle")
                            .foregroundColor(.red)
                            .font(.title)
                        Text("재녹음")
                            .foregroundColor(.red)
                            .font(.caption)
                    default:
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(commentButtonViewModel.QuickStartButtonColor())
                            .font(.title)
                        Text("포스팅")
                            .foregroundColor(commentButtonViewModel.QuickStartButtonColor())
                            .font(.caption)
                    }
                }
            }
        }
    }
}
//#Preview {
//    PostDetailView(post: PostViewModel.createPreview())
//}
