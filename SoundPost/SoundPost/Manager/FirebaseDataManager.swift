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
    func fetchUser (uid: String, completion: @escaping (Result<User, Error>) -> Void){
        Firestore.
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
