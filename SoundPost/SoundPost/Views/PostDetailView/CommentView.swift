import SwiftUI

struct CommentView: View {
    let comment: CommentViewModel
    private var uploadDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: comment.uploadDate)
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                // 프로필 이미지 - URL이 있으면 표시, 없으면 기본 이미지
                if let profileImageURL = comment.profileImage {
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
                
                Text(comment.uploaderName)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(uploadDate)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            // 오디오 재생 버튼
            if let audioURL = comment.audioURL {
                AudioPlayerView(url: audioURL)
            }
        }
        .padding()
    }
}

#Preview {
    let viewModel = CommentViewModel.createPreview(uploaderName: "댓글 작성자")
    
    return CommentView(comment: viewModel)
}
