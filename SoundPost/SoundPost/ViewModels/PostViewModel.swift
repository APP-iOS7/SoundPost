import Foundation

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
    var commentIds: [String]

    init(postId: String,
         uploadDate: Date,
         uploaderName: String,
         profileImage: String? = nil, 
         postImage: String? = nil, 
         isLiked: Bool = false,
         audioURL: URL? = nil,
         likesCount: Int,
         commentsCount: Int,
         commentIds: [String]
    ) {
        self.postId = postId
        self.uploadDate = uploadDate
        self.uploaderName = uploaderName
        self.profileImage = profileImage
        self.postImage = postImage
        self.isLiked = isLiked
        self.audioURL = audioURL
        self.likesCount = likesCount
        self.commensCount = commentsCount
        self.commentIds = commentIds
    }
    
    func toggleLike() {
        isLiked.toggle()
        // TODO: 좋아요 로직 추가 하기
    }
    
}
extension PostViewModel {
    static func createPVMwithPost(post: Post, myId: String) -> PostViewModel {
        return PostViewModel(
            postId: post.id!,
            uploadDate: Date(timeIntervalSince1970: post.uploadDate),
            uploaderName: post.uploaderName,
            profileImage: nil,
            postImage: post.imageURL,
            isLiked: post.likes.contains(myId),
            audioURL: URL(string: post.audioURL),
            likesCount: post.likes.count,
            commentsCount: post.comments.count,
            commentIds: post.comments
        )
    }
}
