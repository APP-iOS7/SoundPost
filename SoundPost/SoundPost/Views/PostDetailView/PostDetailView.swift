import SwiftUI

struct PostDetailView2: View {
    @ObservedObject var postViewModel: PostViewModel
    @StateObject private var quickStartViewModel : QuickStartButtonViewModel
    @State var comments: [CommentViewModel] = []
    @State var isShowingSheet: Bool = false
    
    init(post: PostViewModel, quickStartViewModel : QuickStartButtonViewModel) {
        self.postViewModel = post
        self._quickStartViewModel = StateObject(wrappedValue: quickStartViewModel)

    }
    
    var body: some View {
        ScrollView {
            VStack {
                PostView(post: postViewModel)
                
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
            ModalContentView(quickStartViewModel: quickStartViewModel, isShowingSheet: isShowingSheet, postId: postViewModel.postId)
                .presentationDetents([.height(UIScreen.main.bounds.height / 7)])
                }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            // 하단에 고정된 대답하기 버튼
            Button {
                isShowingSheet.toggle()

            } label: {
                Text("대답 하기")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(.primaryNeon)
            }
        }
        .onAppear() {
            getAllComments()
        }
    }
}
extension PostDetailView2 {
    func getAllComments() {
        for commentid in postViewModel.commentIds {
            FirebaseManager.shared.fetchData(collection: "comments", documentID: commentid) { (result: Comment?) in
                let newCVM = CommentViewModel.createCVMwithComment(comment: result!)
                self.comments.append(newCVM)
                
            }
        }
    }
 }


struct ModalContentView: View {
    @ObservedObject private var commentButtonViewModel: CommentButtonViewModel = CommentButtonViewModel()
    @StateObject var quickStartViewModel : QuickStartButtonViewModel
    @State var isShowingSheet: Bool
    let postId: String?
    var body: some View {
        VStack {
            HStack {
                if commentButtonViewModel.buttonClick == 3 {
                    Button {
                        commentButtonViewModel.QuickStartClose()
                        isShowingSheet.toggle()
                        Task {
                            await quickStartViewModel.NewCommentUpload(postId: postId)
                        }
                        
                    } label: {
                        Text("게시")
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .buttonStyle(.borderedProminent)
                    .tint(.primaryNeon.opacity(1))
                }
                
                Button {
                    commentButtonViewModel.QuickStartSet()
                } label: {
                    VStack {
                        switch commentButtonViewModel.buttonClick {
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
                            Image(systemName: "record.circle")
                                .foregroundColor(.red)
                                .font(.title)
                            Text("녹음")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                }
                
                if commentButtonViewModel.buttonClick == 3 {
                        Button {
                            quickStartViewModel.playRecoed()
                        } label: {
                            Text("다시 듣기")
                                .foregroundStyle(.black)
                        }
                        .padding()
                        .buttonBorderShape(.roundedRectangle(radius: 10))
                        .buttonStyle(.borderedProminent)
                        .tint(.primaryNeon.opacity(1))
                }
            }
        }
        .onChange(of: quickStartViewModel.audioRecoder.countSec) { _, sec in
            print("\(sec)")
            if sec >= 90 {  // 90초가 되었을 때 트리거
                quickStartViewModel.stopRecoring()
                commentButtonViewModel.buttonClick = 3
            }
        }
        .onChange(of: commentButtonViewModel.buttonClick) { _, click in
            if click != 3 && quickStartViewModel.audioRecoder.isPlaying {
                quickStartViewModel.audioRecoder.stopRecord()
                quickStartViewModel.audioRecoder.isPlaying = false
            }
            switch click {
            case 1:
                quickStartViewModel.setRecording()
            case 2:
                quickStartViewModel.startRecoring()
                print("recording")
            case 3:
                quickStartViewModel.stopRecoring()
                print("stop")
            default:
                break
            }
        }
    }
}
//#Preview {
//    PostDetailView(post: PostViewModel.createPreview())
//}
