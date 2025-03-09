import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable {
    @DocumentID var id: String? // Firestore에서 자동 생성될 문서 ID
    let email: String
    let nickname: String
    var isAlarmOn: Bool
    var posts: [String] = [] // 게시물 ID만 저장 (데이터 중복 방지)
    let signupDate: Date
    
}
extension User {
    static func from(dictionary: [String: Any]) -> User? {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []),
              let user = try? JSONDecoder().decode(User.self, from: data)
        else { return nil }
        
        return user
    }
    
    var dictionaryRepresentation: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return nil }
        
        return dictionary
    }
}
