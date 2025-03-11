import Firebase
import FirebaseCoreInternal
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


class FirebaseManager {
    static let shared = FirebaseManager()
    
    let auth: Auth
    let firestore: Firestore
    
    private init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    // Saves
    func saveData<T: Codable & Identifiable & DictionaryConvertible>(targetData: T) {
        let collection: String
        switch targetData {
            case is User:
            collection = "users"
        case is Post:
            collection = "posts"
        case is Comment:
            collection = "comments"
        default:
            fatalError("지원되지 않는 타입입니다.")
        }
        
        guard let dictdata = targetData.dictionaryRepresentation else {
            print("잘못된 데이터")
            print(targetData)
            return }
        
        saveToStore(collection: collection, documentID: targetData.id as! String, data: dictdata)
    }
    
    func fetchData<T: Codable & Identifiable>(collection: String, documentID: String, completion: @escaping (T?) -> Void) {
        firestore.collection(collection).document(documentID).getDocument { document, error in
            if let error = error {
                print("❌ Error getting document: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists, let data = document.data() else {
                print("❌ Document does not exist")
                completion(nil)
                return
            }
            
            let model: T = self.dictToModel(collection: collection, dict: data)
            completion(model)
        }
    }
  
    
    
    func deleteData(collection: String, documentID: String) {
        firestore.collection(collection).document(documentID).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

    func emailSignIn(email: String, password: String, completion: @escaping (_ email: String?, _ uid: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            
            if result != nil {
                print("사용자 이메일: \(String(describing: result?.user.email))")
                print("사용자 uid: \(String(describing: result?.user.uid))")
                completion(result?.user.email, result?.user.uid)
            }
        }
    }
}

extension FirebaseManager {
    func fetchDataAsync<T: Codable>(collection: String, documentID: String) async throws -> T? {
            let documentRef = firestore.collection(collection).document(documentID)
            
            do {
                let documentSnapshot = try await documentRef.getDocument()
                
                guard let data = documentSnapshot.data() else {
                    print("❌ Firebase 데이터 없음: \(documentID)")
                    return nil
                }
                
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                return result
            } catch {
                print("❌ Firebase 데이터 가져오기 실패: \(error.localizedDescription)")
                throw error
            }
        }

    func getAllPosts(completion: @escaping ([Post]) -> Void) {
        print("get all posts!")
        firestore.collection("posts")
            .order(by: "uploadDate", descending: true) // 필드명 확인 필수!
            .addSnapshotListener { querySnapshot, error in
                
                if let error = error {
                    print("❌ Error getting posts: \(error.localizedDescription)")
                    completion([]) // 중복 호출 방지
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    completion([]) // 중복 호출 방지
                    return
                }
                
                let retPosts: [Post] = documents.compactMap { Post.from(dictionary: $0.data()) }
                completion(retPosts)
            }
    }

    
    private func dictToModel<T: Codable & Identifiable> (collection: String, dict: [String: Any]) -> T {
        switch collection {
            case "users":
            return User.from(dictionary: dict) as! T
            case "posts":
            return Post.from(dictionary: dict) as! T
            case "comments":
            return Comment.from(dictionary: dict) as! T
            
        default:
            fatalError("Collection not found")
        }
    }
    
    

    func addPostToUser(userId: String?, postId: String, completion: @escaping ([String]?) -> Void) {
        let userRef = firestore.collection("users").document(userId!)

        
        userRef.updateData([
            "posts": FieldValue.arrayUnion([postId]) // ✅ 배열에 `postId` 추가 (중복 방지)
        ]) { error in
            if let error = error {
                print("❌ 유저 포스트 추가 실패: \(error.localizedDescription)")
                completion(nil) // 실패 시 nil 반환
            } else {
                print("✅ 유저 문서에 포스트 추가 완료: \(postId)")
                
                // 🔹 업데이트된 데이터를 다시 가져와 반환
                userRef.getDocument { document, error in
                    if let error = error {
                        print("❌ 업데이트된 유저 데이터 가져오기 실패: \(error.localizedDescription)")
                        completion(nil)
                    } else if let document = document, document.exists {
                        if let updatedPosts = document.data()?["posts"] as? [String] {
                            print("📌 업데이트된 포스트 배열: \(updatedPosts)")
                            completion(updatedPosts) // ✅ 업데이트된 배열 반환
                        } else {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func addComment(comment: Comment, completion: @escaping (Result<Void, Error>) -> Void) {
        // save comment to store
        saveData(targetData: comment)
        // post update server
        
    }

    
    
    private func saveToStore(collection: String, documentID: String, data: [String: Any]) {
        firestore.collection(collection).document(documentID).setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
}
