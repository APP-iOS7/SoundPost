import SwiftUI

class PostViewModel: ObservableObject {
    var uploaderName: String
    var profileImage: String? // URL 문자열
    var postImage: String? // URL 문자열
    var postId: String
    var audioURL: URL?
    @Published var isLiked: Bool = false

    init(postId: String,
         uploaderName: String, 
         profileImage: String? = nil, 
         postImage: String? = nil, 
         isLiked: Bool = false,
         audioURL: URL? = nil) {
        
        self.postId = postId
        self.uploaderName = uploaderName
        self.profileImage = profileImage
        self.postImage = postImage
        self.isLiked = isLiked
        self.audioURL = audioURL
    }
    
    func toggleLike() {
        isLiked.toggle()
        // TODO: 좋아요 로직 추가 하기
    }
    
    // 미리보기용 인스턴스 생성 메서드
    static func createPreview(uploaderName: String = "사용자") -> PostViewModel {
        let sampleAudioURL = URL(string: "https://filesamples.com/samples/audio/aac/sample3.aac")
        
        return PostViewModel(
            postId: UUID().uuidString,
            uploaderName: uploaderName,
            audioURL: sampleAudioURL
        )
    }
}
