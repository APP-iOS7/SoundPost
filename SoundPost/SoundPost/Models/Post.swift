import SwiftUICore
import FirebaseFirestore

struct Post: Codable, Identifiable, DictionaryConvertible {
    var id: String?
    let uploadDate: Double
    var audioURL: String = "" // 오디오 파일 저장 URL
    var comments: [String] = [] // 댓글 ID만 저장 (데이터 중복 방지)
    var imageURL: String? = nil // 이미지 파일도 URL로 저장
    let uploaderID: String // 유저 ID만 저장 (참조 형태)
    var likes: [String] = [] // 좋아요한 유저 ID 리스트
    let uploaderName: String
    
    init(id: String? = nil, uploadDate: Double = Date().timeIntervalSince1970, audioURL: String, comments: [String] = [], imageURL: String? = nil, uploaderID: String, likes: [String] = [], uploaderName: String) {
        self.id = id
        self.uploadDate = uploadDate
        self.audioURL = audioURL
        self.comments = comments
        self.imageURL = imageURL
        self.uploaderID = uploaderID
        self.likes = likes
        self.uploaderName = uploaderName
    }
}
