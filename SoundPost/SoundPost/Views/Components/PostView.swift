import SwiftUI
import AVFoundation

struct PostView: View {
    @ObservedObject var post: PostViewModel
    @State private var imageHeight: CGFloat? = nil

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                // 프로필 이미지 - URL이 있으면 표시, 없으면 기본 이미지
                if let profileImageURL = post.profileImage {
                    AsyncImage(url: URL(string: profileImageURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "person.circle")
                            .resizable()
                    }
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                } else {
                    // 기본 이미지
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                
                Text(post.uploaderName)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // 좋아요 버튼
                Button {
                    post.toggleLike()
                } label: {
                    Image(systemName: post.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(post.isLiked ? .red : .secondary)
                }
            }
            
            // 포스트 이미지
            if let postImageURL = post.postImage {
                // 이미지 로딩 및 표시
                AsyncImage(url: URL(string: postImageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        // 이미지가 로드되면 해당 이미지를 표시
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(
                                // 이미지의 크기를 측정하여 높이 계산
                                GeometryReader { geometry in
                                    Color.clear.onAppear {
                                        let imageWidth = UIScreen.main.bounds.width - 32 // 화면 너비 - 패딩
                                        self.imageHeight = min(geometry.size.height, imageWidth * 2)
                                    }
                                }
                            )
                    case .empty:
                        ProgressView()
                    case .failure, _:
                        EmptyView()
                    }
                }
                // 높이 조정
                .frame(height: imageHeight)
                .frame(minHeight: imageHeight == nil ? 100 : 0)
            }
            
            // 오디오 재생 버튼
            if let audioURL = post.audioURL {
                AudioPlayerView(url: audioURL)
            }
        }
        .padding()
    }
}

#Preview {
    let viewModel = PostViewModel.createPreview(uploaderName: "사용자")
    viewModel.postImage = "https://picsum.photos/600/400"
    
    return PostView(post: viewModel)
}

#Preview("no image") {
    let viewModel = PostViewModel.createPreview(uploaderName: "사용자")
    return PostView(post: viewModel)
}
