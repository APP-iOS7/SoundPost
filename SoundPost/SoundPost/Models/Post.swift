import SwiftUICore
import FirebaseFirestore

struct Post: Codable, Identifiable {
    @DocumentID var id: String?
    let uploadDate: Date
    var audioURL: String = "" // 오디오 파일 저장 URL
    var comments: [String] = [] // 댓글 ID만 저장 (데이터 중복 방지)
    var imageURL: String? = nil // 이미지 파일도 URL로 저장
    let uploaderID: String // 유저 ID만 저장 (참조 형태)
    var likes: [String] = [] // 좋아요한 유저 ID 리스트
}
extension Post {
    static func from(dictionary: [String: Any]) -> Post? {
           guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []),
                 let post = try? JSONDecoder().decode(Post.self, from: data) else {
               return nil
           }
        return post
       }
    
    var dictionaryRepresentation: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return nil }
        
        return dictionary
    }
}
