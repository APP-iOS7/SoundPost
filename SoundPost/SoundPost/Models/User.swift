import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable, DictionaryConvertible {
    @DocumentID var id: String? // Firestore에서 자동 생성될 문서 ID
    let email: String
    let nickname: String
    var isAlarmOn: Bool
    var posts: [String] = [] // 게시물 ID만 저장 (데이터 중복 방지)
    let signupDate: Date
    
}

