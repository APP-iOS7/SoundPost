import Foundation

class CommentViewModel {
    let commentId: String
    let uploadDate: Date
    var uploaderName: String
    var profileImage: String? // URL 문자열
    var audioURL: URL?
    
    init(commentId: String,
         uploadDate: Date,
         uploaderName: String,
         profileImage: String? = nil,
         audioURL: URL? = nil
    ) {
        self.commentId = commentId
        self.uploadDate = uploadDate
        self.uploaderName = uploaderName
        self.profileImage = profileImage
        self.audioURL = audioURL
    }
    
    // 미리보기용 인스턴스 생성 메서드
    static func createPreview(uploaderName: String = "댓글 작성자") -> CommentViewModel {
        let sampleAudioURL = URL(string: "https://filesamples.com/samples/audio/aac/sample3.aac")
        
        return CommentViewModel(
            commentId: UUID().uuidString,
            uploadDate: Date(),
            uploaderName: uploaderName,
            audioURL: sampleAudioURL
        )
    }
}
extension CommentViewModel {
    static func createCVMwithComment(comment: Comment, nickname: String) -> CommentViewModel {
        return CommentViewModel(
            commentId: comment.id!,
            uploadDate: Date(timeIntervalSince1970: comment.uploadDate),
            uploaderName: nickname,
            audioURL: URL(string: comment.audioURL))
    }
    
}
