import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable, DictionaryConvertible, Hashable {
    var id: String? // Firestore에서 자동 생성될 문서 ID
    let email: String
    let nickname: String
    var isAlarmOn: Bool
    var posts: [String] = [] // 게시물 ID만 저장 (데이터 중복 방지)
    let signupDate: Double
    
    init(id: String? = nil, email: String, nickname: String, isAlarmOn: Bool = true, posts: [String] = [], signupDate: Double = Date().timeIntervalSince1970) {
        self.id = id
        self.email = email
        self.nickname = nickname
        self.isAlarmOn = isAlarmOn
        self.posts = posts
        self.signupDate = signupDate
    }
}

extension User {
    static func createUser(_ email: String, _ nickname: String) -> User {
        return User(email: email, nickname: nickname, isAlarmOn: true, posts: [], signupDate: TimeInterval())
    }
}

