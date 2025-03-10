import Foundation
import FirebaseFirestore

struct Comment: Codable, Identifiable, DictionaryConvertible {
    var id: String?
    let uploadDate: Double
    let audioURL: String // 오디오 파일 저장 URL
    let uploaderID: String // 유저 ID만 저장
    let targetPostID: String // 대상 게시물 ID만 저장
    
    init(id: String? = nil, uploadDate: Double = Date().timeIntervalSince1970, audioURL: String, uploaderID: String, targetPostID: String) {
        self.id = id
        self.uploadDate = uploadDate
        self.audioURL = audioURL
        self.uploaderID = uploaderID
        self.targetPostID = targetPostID
    }
    
}
