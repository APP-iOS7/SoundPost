import Foundation
import FirebaseFirestore

struct Comment: Codable, Identifiable {
    @DocumentID var id: String?
    let uploadDate: Date
    let audioURL: String // 오디오 파일 저장 URL
    let uploaderID: String // 유저 ID만 저장
    let targetPostID: String // 대상 게시물 ID만 저장
}
extension Comment {
    static func from(dictionary: [String: Any]) -> Comment? {
           guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []),
                 let comment = try? JSONDecoder().decode(Comment.self, from: data) else {
               return nil
           }
        return comment
       }
    
    var dictionaryRepresentation: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return nil }
        
        return dictionary
    }
}
