import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


class FirebaseManager {
    static let shared = FirebaseManager()
    
    let auth: Auth
    let firestore: Firestore
    let storage: Storage
    
    private init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
    }
}

extension FirebaseManager {
    // Saves
    func saveData<T: Codable & Identifiable>(targetData: T) {
        switch targetData {
        case let user as User:
            guard let dictdata = user.dictionaryRepresentation else {
                print("잘못된 유저 데이터")
                return }
            
            saveToStore(collection: "users", documentID: user.id ?? UUID().uuidString, data: user.dictionaryRepresentation ?? [:])
            
        case let post as Post:
            guard let dictdata = post.dictionaryRepresentation else {
                print("잘못된 포스트 데이터")
                return }
            
            saveToStore(collection: "posts", documentID: post.id ?? UUID().uuidString, data: post.dictionaryRepresentation ?? [:])
            
        case let comment as Comment:
            guard let dictdata = comment.dictionaryRepresentation else {
                print("잘못된 댓글 데이터")
                return }
            
            saveToStore(collection: "comments", documentID: comment.id ?? UUID().uuidString, data: comment.dictionaryRepresentation ?? [:])
        default:
            print("Not a valid DataModel")
        }
    }
    
    func fetchData<T: Codable & Identifiable>(collection: String, documentID: String, completion: @escaping ([String: Any]) -> T) {
        firestore.collection(collection).document(documentID).getDocument { document, error in
            if let error = error {
                print("Error getting document: \(error)")
            } else {
                if let document = document, document.exists {
                    let dataDescription = document.data() ?? [:]
                    
                    
                }
            }
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
    
    private func saveToStore(collection: String, documentID: String, data: [String: Any]) {
        firestore.collection(collection).document(documentID).setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    func emailSignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                
                return
            }
            
            if result != nil {
                print("사용자 이메일: \(String(describing: result?.user.email))")
                print("사용자 uid: \(String(describing: result?.user.uid))")
                
            }
        }
    }
}
