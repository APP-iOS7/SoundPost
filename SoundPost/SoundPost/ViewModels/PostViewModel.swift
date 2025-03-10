import SwiftUI

class PostViewModel: ObservableObject {
    let postId: String
    let uploadDate: Date
    var uploaderName: String
    var profileImage: String? // URL 문자열
    var postImage: String? // URL 문자열
    var audioURL: URL?
    var likesCount: Int
    var commensCount: Int
    @Published var isLiked: Bool = false

    init(postId: String,
         uploadedDate: Date,
         uploaderName: String,
         profileImage: String? = nil, 
         postImage: String? = nil, 
         isLiked: Bool = false,
         audioURL: URL? = nil,
         likesCount: Int,
         commentsCount: Int
    ) {
        self.postId = postId
        self.uploadDate = uploadedDate
        self.uploaderName = uploaderName
        self.profileImage = profileImage
        self.postImage = postImage
        self.isLiked = isLiked
        self.audioURL = audioURL
        self.likesCount = likesCount
        self.commensCount = commentsCount
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
            uploadedDate: Date(),
            uploaderName: uploaderName,
            audioURL: sampleAudioURL,
            likesCount: Int.random(in: 0...30),
            commentsCount: Int.random(in: 0...30)
        )
    }
}
