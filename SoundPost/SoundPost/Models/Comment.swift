import Foundation
import FirebaseFirestore

struct Comment: Codable, Identifiable {
    @DocumentID var id: String?
    let uploadDate: Date
    let audioURL: String // 오디오 파일 저장 URL
    let uploaderID: String // 유저 ID만 저장
    let targetPostID: String // 대상 게시물 ID만 저장
}
